pub const RetentionType = enum {
    retain,
    delete,

    pub const json_field_names = .{
        .retain = "Retain",
        .delete = "Delete",
    };
};
