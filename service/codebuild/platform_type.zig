pub const PlatformType = enum {
    debian,
    amazon_linux,
    ubuntu,
    windows_server,

    pub const json_field_names = .{
        .debian = "DEBIAN",
        .amazon_linux = "AMAZON_LINUX",
        .ubuntu = "UBUNTU",
        .windows_server = "WINDOWS_SERVER",
    };
};
