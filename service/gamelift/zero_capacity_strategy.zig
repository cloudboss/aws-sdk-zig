pub const ZeroCapacityStrategy = enum {
    manual,
    scale_to_and_from_zero,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .scale_to_and_from_zero = "SCALE_TO_AND_FROM_ZERO",
    };
};
