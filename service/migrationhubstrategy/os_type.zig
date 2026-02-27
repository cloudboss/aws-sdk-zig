pub const OSType = enum {
    linux,
    windows,

    pub const json_field_names = .{
        .linux = "LINUX",
        .windows = "WINDOWS",
    };
};
