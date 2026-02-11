pub const AttributeAction = enum {
    add,
    put,
    delete,

    pub const json_field_names = .{
        .add = "ADD",
        .put = "PUT",
        .delete = "DELETE",
    };
};
