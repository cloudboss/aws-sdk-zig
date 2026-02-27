pub const AssetState = enum {
    active,
    retiring,
    isolated,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .retiring = "RETIRING",
        .isolated = "ISOLATED",
    };
};
