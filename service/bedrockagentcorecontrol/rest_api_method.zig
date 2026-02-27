pub const RestApiMethod = enum {
    get,
    delete,
    head,
    options,
    patch,
    put,
    post,

    pub const json_field_names = .{
        .get = "GET",
        .delete = "DELETE",
        .head = "HEAD",
        .options = "OPTIONS",
        .patch = "PATCH",
        .put = "PUT",
        .post = "POST",
    };
};
