pub const ArcThickness = enum {
    small,
    medium,
    large,
    whole,

    pub const json_field_names = .{
        .small = "SMALL",
        .medium = "MEDIUM",
        .large = "LARGE",
        .whole = "WHOLE",
    };
};
