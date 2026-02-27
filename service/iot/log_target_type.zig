pub const LogTargetType = enum {
    default,
    thing_group,
    client_id,
    source_ip,
    principal_id,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .thing_group = "THING_GROUP",
        .client_id = "CLIENT_ID",
        .source_ip = "SOURCE_IP",
        .principal_id = "PRINCIPAL_ID",
    };
};
