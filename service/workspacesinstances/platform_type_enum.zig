pub const PlatformTypeEnum = enum {
    windows,
    windows_byol,
    linux_unix,
    ubuntu_pro,
    rhel,
    linux_byol,
    suse,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .windows_byol = "WINDOWS_BYOL",
        .linux_unix = "LINUX_UNIX",
        .ubuntu_pro = "UBUNTU_PRO",
        .rhel = "RHEL",
        .linux_byol = "LINUX_BYOL",
        .suse = "SUSE",
    };
};
