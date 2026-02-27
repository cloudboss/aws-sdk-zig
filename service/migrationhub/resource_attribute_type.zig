pub const ResourceAttributeType = enum {
    ipv4_address,
    ipv6_address,
    mac_address,
    fqdn,
    vm_manager_id,
    vm_managed_object_reference,
    vm_name,
    vm_path,
    bios_id,
    motherboard_serial_number,

    pub const json_field_names = .{
        .ipv4_address = "IPV4_ADDRESS",
        .ipv6_address = "IPV6_ADDRESS",
        .mac_address = "MAC_ADDRESS",
        .fqdn = "FQDN",
        .vm_manager_id = "VM_MANAGER_ID",
        .vm_managed_object_reference = "VM_MANAGED_OBJECT_REFERENCE",
        .vm_name = "VM_NAME",
        .vm_path = "VM_PATH",
        .bios_id = "BIOS_ID",
        .motherboard_serial_number = "MOTHERBOARD_SERIAL_NUMBER",
    };
};
