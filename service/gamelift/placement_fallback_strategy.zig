pub const PlacementFallbackStrategy = enum {
    default_after_single_pass,
    none,

    pub const json_field_names = .{
        .default_after_single_pass = "DEFAULT_AFTER_SINGLE_PASS",
        .none = "NONE",
    };
};
