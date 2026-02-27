pub const FileSystemLocationType = enum {
    shared,
    local,

    pub const json_field_names = .{
        .shared = "SHARED",
        .local = "LOCAL",
    };
};
