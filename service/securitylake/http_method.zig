pub const HttpMethod = enum {
    post,
    put,

    pub const json_field_names = .{
        .post = "POST",
        .put = "PUT",
    };
};
