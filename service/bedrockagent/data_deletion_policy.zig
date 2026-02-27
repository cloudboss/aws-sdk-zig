pub const DataDeletionPolicy = enum {
    retain,
    delete,

    pub const json_field_names = .{
        .retain = "RETAIN",
        .delete = "DELETE",
    };
};
