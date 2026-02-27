pub const ActionAfterCompletion = enum {
    none,
    delete,

    pub const json_field_names = .{
        .none = "NONE",
        .delete = "DELETE",
    };
};
