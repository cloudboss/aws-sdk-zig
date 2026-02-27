pub const SecurityPolicyResourceType = enum {
    server,
    connector,

    pub const json_field_names = .{
        .server = "SERVER",
        .connector = "CONNECTOR",
    };
};
