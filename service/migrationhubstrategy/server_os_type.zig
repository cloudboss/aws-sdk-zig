pub const ServerOsType = enum {
    windows_server,
    amazon_linux,
    end_of_support_windows_server,
    redhat,
    other,

    pub const json_field_names = .{
        .windows_server = "windowsServer",
        .amazon_linux = "amazonLinux",
        .end_of_support_windows_server = "endOfSupportWindowsServer",
        .redhat = "redhat",
        .other = "other",
    };
};
