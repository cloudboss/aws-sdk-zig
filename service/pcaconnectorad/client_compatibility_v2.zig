pub const ClientCompatibilityV2 = enum {
    windows_server_2003,
    windows_server_2008,
    windows_server_2008_r2,
    windows_server_2012,
    windows_server_2012_r2,
    windows_server_2016,

    pub const json_field_names = .{
        .windows_server_2003 = "WINDOWS_SERVER_2003",
        .windows_server_2008 = "WINDOWS_SERVER_2008",
        .windows_server_2008_r2 = "WINDOWS_SERVER_2008_R2",
        .windows_server_2012 = "WINDOWS_SERVER_2012",
        .windows_server_2012_r2 = "WINDOWS_SERVER_2012_R2",
        .windows_server_2016 = "WINDOWS_SERVER_2016",
    };
};
