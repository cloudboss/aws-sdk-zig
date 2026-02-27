pub const AttackLayer = enum {
    network,
    application,

    pub const json_field_names = .{
        .network = "NETWORK",
        .application = "APPLICATION",
    };
};
