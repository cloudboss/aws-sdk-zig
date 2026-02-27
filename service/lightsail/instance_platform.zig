pub const InstancePlatform = enum {
    linux_unix,
    windows,

    pub const json_field_names = .{
        .linux_unix = "LinuxUnix",
        .windows = "Windows",
    };
};
