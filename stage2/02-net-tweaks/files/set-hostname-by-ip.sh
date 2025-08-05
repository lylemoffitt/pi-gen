    #!/bin/sh

    # This script runs when a network interface comes up.
    # It attempts to set the hostname based on the interface's IP address.

    # Check if a specific interface is bringing up (optional, for targeted actions)
    # if [ "$IFACE" != "eth0" ]; then
    #     exit 0
    # fi

    # Get the IP address of the interface
    IP_ADDRESS=$(ip -4 addr show dev "$IFACE" | grep -oP 'inet \K[\d.]+')

    if [ -n "$IP_ADDRESS" ]; then
        # Example: Set hostname to "host-X-Y-Z-W" based on IP 192.168.1.10
        NEW_HOSTNAME="pi-$(echo "$IP_ADDRESS"  | cut -d. -f 4 )"
        
        # Set the hostname
        hostname "$NEW_HOSTNAME"
        
        # Update /etc/hostname for persistence (optional, if you want it to survive reboots)
        echo "$NEW_HOSTNAME" | sudo tee /etc/hostname > /dev/null
        
        # Update /etc/hosts (optional, for local name resolution)
        sudo sed -i "/^127.0.1.1/c\\127.0.1.1\t$NEW_HOSTNAME" /etc/hosts
        echo "$IP_ADDRESS\t$NEW_HOSTNAME" | sudo tee -a /etc/hosts > /dev/null
    fi

    exit 0