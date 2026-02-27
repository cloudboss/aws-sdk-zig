pub const ItemType = enum {
    object,
    folder,

    pub const json_field_names = .{
        .object = "OBJECT",
        .folder = "FOLDER",
    };
};
