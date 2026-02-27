pub const MatchFieldType = enum {
    uri,
    query_string,
    header,
    method,
    body,
    single_query_arg,
    all_query_args,

    pub const json_field_names = .{
        .uri = "URI",
        .query_string = "QUERY_STRING",
        .header = "HEADER",
        .method = "METHOD",
        .body = "BODY",
        .single_query_arg = "SINGLE_QUERY_ARG",
        .all_query_args = "ALL_QUERY_ARGS",
    };
};
