pub const OriginType = enum {
    user,
    replication,
    ttl,

    pub const json_field_names = .{
        .user = "USER",
        .replication = "REPLICATION",
        .ttl = "TTL",
    };
};
