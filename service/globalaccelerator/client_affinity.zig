pub const ClientAffinity = enum {
    none,
    source_ip,

    pub const json_field_names = .{
        .none = "NONE",
        .source_ip = "SOURCE_IP",
    };
};
