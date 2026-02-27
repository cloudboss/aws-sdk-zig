pub const FallbackResult = enum {
    allow,
    deny,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .deny = "DENY",
    };
};
