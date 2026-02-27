pub const ComputeAssetState = enum {
    active,
    isolated,
    retiring,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .isolated = "ISOLATED",
        .retiring = "RETIRING",
    };
};
