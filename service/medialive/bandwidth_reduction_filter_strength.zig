/// Bandwidth Reduction Filter Strength
pub const BandwidthReductionFilterStrength = enum {
    auto,
    strength_1,
    strength_2,
    strength_3,
    strength_4,

    pub const json_field_names = .{
        .auto = "AUTO",
        .strength_1 = "STRENGTH_1",
        .strength_2 = "STRENGTH_2",
        .strength_3 = "STRENGTH_3",
        .strength_4 = "STRENGTH_4",
    };
};
