pub const ApiDestinationHttpMethod = enum {
    post,
    get,
    head,
    options,
    put,
    patch,
    delete,

    pub const json_field_names = .{
        .post = "POST",
        .get = "GET",
        .head = "HEAD",
        .options = "OPTIONS",
        .put = "PUT",
        .patch = "PATCH",
        .delete = "DELETE",
    };
};
