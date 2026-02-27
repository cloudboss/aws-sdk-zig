pub const StatementEffect = enum {
    allow,
    deny,

    pub const json_field_names = .{
        .allow = "Allow",
        .deny = "Deny",
    };
};
