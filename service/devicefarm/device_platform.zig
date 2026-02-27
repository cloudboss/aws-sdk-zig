pub const DevicePlatform = enum {
    android,
    ios,

    pub const json_field_names = .{
        .android = "ANDROID",
        .ios = "IOS",
    };
};
