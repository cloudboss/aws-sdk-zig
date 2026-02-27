pub const ImpactLevel = enum {
    il2,
    il4,
    il5,
    il6,
    il99,

    pub const json_field_names = .{
        .il2 = "IL2",
        .il4 = "IL4",
        .il5 = "IL5",
        .il6 = "IL6",
        .il99 = "IL99",
    };
};
