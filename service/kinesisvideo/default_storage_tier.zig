pub const DefaultStorageTier = enum {
    hot,
    warm,

    pub const json_field_names = .{
        .hot = "HOT",
        .warm = "WARM",
    };
};
