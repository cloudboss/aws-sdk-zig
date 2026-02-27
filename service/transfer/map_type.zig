pub const MapType = enum {
    file,
    directory,

    pub const json_field_names = .{
        .file = "FILE",
        .directory = "DIRECTORY",
    };
};
