pub const RetentionAction = enum {
    none,
    delete,
    permanently_delete,

    pub const json_field_names = .{
        .none = "NONE",
        .delete = "DELETE",
        .permanently_delete = "PERMANENTLY_DELETE",
    };
};
