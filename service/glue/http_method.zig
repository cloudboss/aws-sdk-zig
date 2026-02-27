pub const HTTPMethod = enum {
    get,
    post,

    pub const json_field_names = .{
        .get = "GET",
        .post = "POST",
    };
};
