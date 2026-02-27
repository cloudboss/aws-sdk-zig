pub const ConnectionOAuthHttpMethod = enum {
    get,
    post,
    put,

    pub const json_field_names = .{
        .get = "GET",
        .post = "POST",
        .put = "PUT",
    };
};
