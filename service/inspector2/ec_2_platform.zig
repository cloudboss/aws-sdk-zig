pub const Ec2Platform = enum {
    windows,
    linux,
    unknown,
    macos,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .linux = "LINUX",
        .unknown = "UNKNOWN",
        .macos = "MACOS",
    };
};
