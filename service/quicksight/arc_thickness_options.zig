pub const ArcThicknessOptions = enum {
    small,
    medium,
    large,

    pub const json_field_names = .{
        .small = "SMALL",
        .medium = "MEDIUM",
        .large = "LARGE",
    };
};
