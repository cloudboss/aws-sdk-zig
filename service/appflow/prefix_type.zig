pub const PrefixType = enum {
    filename,
    path,
    path_and_filename,

    pub const json_field_names = .{
        .filename = "FILENAME",
        .path = "PATH",
        .path_and_filename = "PATH_AND_FILENAME",
    };
};
