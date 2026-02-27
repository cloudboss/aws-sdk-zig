pub const ClientCompatibilityV4 = enum {
    windows_server_2012,
    windows_server_2012_r2,
    windows_server_2016,

    pub const json_field_names = .{
        .windows_server_2012 = "WINDOWS_SERVER_2012",
        .windows_server_2012_r2 = "WINDOWS_SERVER_2012_R2",
        .windows_server_2016 = "WINDOWS_SERVER_2016",
    };
};
