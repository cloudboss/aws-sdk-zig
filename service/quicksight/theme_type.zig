pub const ThemeType = enum {
    quicksight,
    custom,
    all,

    pub const json_field_names = .{
        .quicksight = "QUICKSIGHT",
        .custom = "CUSTOM",
        .all = "ALL",
    };
};
