pub const ParameterTier = enum {
    standard,
    advanced,
    intelligent_tiering,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .advanced = "ADVANCED",
        .intelligent_tiering = "INTELLIGENT_TIERING",
    };
};
