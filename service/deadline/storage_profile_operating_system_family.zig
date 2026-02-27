pub const StorageProfileOperatingSystemFamily = enum {
    windows,
    linux,
    macos,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .linux = "LINUX",
        .macos = "MACOS",
    };
};
