pub const PlatformDifference = enum {
    hypervisor,
    network_interface,
    storage_interface,
    instance_store_availability,
    virtualization_type,
    architecture,

    pub const json_field_names = .{
        .hypervisor = "HYPERVISOR",
        .network_interface = "NETWORK_INTERFACE",
        .storage_interface = "STORAGE_INTERFACE",
        .instance_store_availability = "INSTANCE_STORE_AVAILABILITY",
        .virtualization_type = "VIRTUALIZATION_TYPE",
        .architecture = "ARCHITECTURE",
    };
};
