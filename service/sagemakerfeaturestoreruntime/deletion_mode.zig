pub const DeletionMode = enum {
    soft_delete,
    hard_delete,

    pub const json_field_names = .{
        .soft_delete = "SOFT_DELETE",
        .hard_delete = "HARD_DELETE",
    };
};
