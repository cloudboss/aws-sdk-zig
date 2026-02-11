pub const EndPointType = enum {
    kafka_bootstrap_servers,

    pub const json_field_names = .{
        .kafka_bootstrap_servers = "KAFKA_BOOTSTRAP_SERVERS",
    };
};
