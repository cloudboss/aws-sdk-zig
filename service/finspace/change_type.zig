pub const ChangeType = enum {
    put,
    delete,

    pub const json_field_names = .{
        .put = "PUT",
        .delete = "DELETE",
    };
};
