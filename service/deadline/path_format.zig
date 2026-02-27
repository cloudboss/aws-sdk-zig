pub const PathFormat = enum {
    windows,
    posix,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .posix = "POSIX",
    };
};
