pub const ApiKeyCredentialLocation = enum {
    header,
    query_parameter,

    pub const json_field_names = .{
        .header = "HEADER",
        .query_parameter = "QUERY_PARAMETER",
    };
};
