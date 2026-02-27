pub const OntapFileSystemUserType = enum {
    unix,
    windows,

    pub const json_field_names = .{
        .unix = "UNIX",
        .windows = "WINDOWS",
    };
};
