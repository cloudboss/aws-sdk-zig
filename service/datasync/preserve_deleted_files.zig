pub const PreserveDeletedFiles = enum {
    preserve,
    remove,

    pub const json_field_names = .{
        .preserve = "PRESERVE",
        .remove = "REMOVE",
    };
};
