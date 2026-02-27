pub const RestApiMethod = enum {
    get,
    put,
    post,
    patch,
    delete,

    pub const json_field_names = .{
        .get = "GET",
        .put = "PUT",
        .post = "POST",
        .patch = "PATCH",
        .delete = "DELETE",
    };
};
