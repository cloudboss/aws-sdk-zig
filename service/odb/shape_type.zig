pub const ShapeType = enum {
    amd,
    intel,
    intel_flex_x9,
    ampere_flex_a1,

    pub const json_field_names = .{
        .amd = "AMD",
        .intel = "INTEL",
        .intel_flex_x9 = "INTEL_FLEX_X9",
        .ampere_flex_a1 = "AMPERE_FLEX_A1",
    };
};
