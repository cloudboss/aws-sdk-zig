pub const RelativeFontSize = enum {
    extra_small,
    small,
    medium,
    large,
    extra_large,

    pub const json_field_names = .{
        .extra_small = "EXTRA_SMALL",
        .small = "SMALL",
        .medium = "MEDIUM",
        .large = "LARGE",
        .extra_large = "EXTRA_LARGE",
    };
};
