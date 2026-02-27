pub const FieldToProtectType = enum {
    single_header,
    single_cookie,
    single_query_argument,
    query_string,
    body,

    pub const json_field_names = .{
        .single_header = "SINGLE_HEADER",
        .single_cookie = "SINGLE_COOKIE",
        .single_query_argument = "SINGLE_QUERY_ARGUMENT",
        .query_string = "QUERY_STRING",
        .body = "BODY",
    };
};
