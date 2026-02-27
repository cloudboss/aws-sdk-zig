pub const PlacementStrategyType = enum {
    random,
    spread,
    binpack,

    pub const json_field_names = .{
        .random = "RANDOM",
        .spread = "SPREAD",
        .binpack = "BINPACK",
    };
};
