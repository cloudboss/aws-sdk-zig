pub const PropertyLocation = enum {
    header,
    body,
    query_param,
    path,

    pub const json_field_names = .{
        .header = "HEADER",
        .body = "BODY",
        .query_param = "QUERY_PARAM",
        .path = "PATH",
    };
};
