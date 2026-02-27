pub const HttpMethod = enum {
    delete,
    get,
    head,
    options,
    patch,
    post,
    put,

    pub const json_field_names = .{
        .delete = "DELETE",
        .get = "GET",
        .head = "HEAD",
        .options = "OPTIONS",
        .patch = "PATCH",
        .post = "POST",
        .put = "PUT",
    };
};
