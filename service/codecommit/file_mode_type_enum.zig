pub const FileModeTypeEnum = enum {
    executable,
    normal,
    symlink,

    pub const json_field_names = .{
        .executable = "EXECUTABLE",
        .normal = "NORMAL",
        .symlink = "SYMLINK",
    };
};
