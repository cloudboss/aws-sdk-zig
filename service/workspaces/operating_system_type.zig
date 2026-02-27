pub const OperatingSystemType = enum {
    windows,
    linux,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .linux = "LINUX",
    };
};
