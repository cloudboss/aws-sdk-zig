pub const DatePartitionDelimiterValue = enum {
    slash,
    underscore,
    dash,
    none,

    pub const json_field_names = .{
        .slash = "SLASH",
        .underscore = "UNDERSCORE",
        .dash = "DASH",
        .none = "NONE",
    };
};
