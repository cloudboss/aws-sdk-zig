pub const PrimaryValueDisplayType = enum {
    hidden,
    comparison,
    actual,

    pub const json_field_names = .{
        .hidden = "HIDDEN",
        .comparison = "COMPARISON",
        .actual = "ACTUAL",
    };
};
