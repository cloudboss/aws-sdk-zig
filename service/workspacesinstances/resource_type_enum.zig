pub const ResourceTypeEnum = enum {
    instance,
    volume,
    spot_instances_request,
    network_interface,

    pub const json_field_names = .{
        .instance = "INSTANCE",
        .volume = "VOLUME",
        .spot_instances_request = "SPOT_INSTANCES_REQUEST",
        .network_interface = "NETWORK_INTERFACE",
    };
};
