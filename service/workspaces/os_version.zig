pub const OSVersion = enum {
    windows_10,
    windows_11,

    pub const json_field_names = .{
        .windows_10 = "Windows_10",
        .windows_11 = "Windows_11",
    };
};
