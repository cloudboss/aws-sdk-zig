pub const CustomRoutingDestinationTrafficState = enum {
    allow,
    deny,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .deny = "DENY",
    };
};
