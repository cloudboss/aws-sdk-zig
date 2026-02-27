pub const OperatingSystem = enum {
    windows_2012,
    amazon_linux,
    amazon_linux_2,
    windows_2016,
    amazon_linux_2023,
    windows_2022,

    pub const json_field_names = .{
        .windows_2012 = "WINDOWS_2012",
        .amazon_linux = "AMAZON_LINUX",
        .amazon_linux_2 = "AMAZON_LINUX_2",
        .windows_2016 = "WINDOWS_2016",
        .amazon_linux_2023 = "AMAZON_LINUX_2023",
        .windows_2022 = "WINDOWS_2022",
    };
};
