pub const Platform = enum {
    ios,
    android,

    pub const json_field_names = .{
        .ios = "IOS",
        .android = "ANDROID",
    };
};
