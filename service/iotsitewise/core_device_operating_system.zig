pub const CoreDeviceOperatingSystem = enum {
    linux_aarch64,
    linux_amd64,
    windows_amd64,

    pub const json_field_names = .{
        .linux_aarch64 = "LINUX_AARCH64",
        .linux_amd64 = "LINUX_AMD64",
        .windows_amd64 = "WINDOWS_AMD64",
    };
};
