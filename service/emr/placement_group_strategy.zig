pub const PlacementGroupStrategy = enum {
    spread,
    partition,
    cluster,
    none,

    pub const json_field_names = .{
        .spread = "SPREAD",
        .partition = "PARTITION",
        .cluster = "CLUSTER",
        .none = "NONE",
    };
};
