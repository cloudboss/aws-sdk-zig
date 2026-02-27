pub const MethodName = enum {
    put,
    get,
    delete,
    head,

    pub const json_field_names = .{
        .put = "PUT",
        .get = "GET",
        .delete = "DELETE",
        .head = "HEAD",
    };
};
