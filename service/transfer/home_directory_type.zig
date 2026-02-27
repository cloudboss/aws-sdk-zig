pub const HomeDirectoryType = enum {
    path,
    logical,

    pub const json_field_names = .{
        .path = "PATH",
        .logical = "LOGICAL",
    };
};
