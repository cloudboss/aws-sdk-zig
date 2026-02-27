pub const AppMonitorPlatform = enum {
    web,
    android,
    ios,

    pub const json_field_names = .{
        .web = "WEB",
        .android = "ANDROID",
        .ios = "IOS",
    };
};
