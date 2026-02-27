pub const TargetPlatformOs = enum {
    android,
    linux,

    pub const json_field_names = .{
        .android = "ANDROID",
        .linux = "LINUX",
    };
};
