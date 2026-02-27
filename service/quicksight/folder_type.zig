pub const FolderType = enum {
    shared,
    restricted,

    pub const json_field_names = .{
        .shared = "SHARED",
        .restricted = "RESTRICTED",
    };
};
