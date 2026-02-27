pub const HttpMethod = enum {
    get,
    head,
    post,
    put,
    delete,
    connect,
    options,
    trace,
    patch,

    pub const json_field_names = .{
        .get = "GET",
        .head = "HEAD",
        .post = "POST",
        .put = "PUT",
        .delete = "DELETE",
        .connect = "CONNECT",
        .options = "OPTIONS",
        .trace = "TRACE",
        .patch = "PATCH",
    };
};
