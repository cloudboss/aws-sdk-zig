pub const DirectorySize = enum {
    small,
    large,

    pub const json_field_names = .{
        .small = "SMALL",
        .large = "LARGE",
    };
};
