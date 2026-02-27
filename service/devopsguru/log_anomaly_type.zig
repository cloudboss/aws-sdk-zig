pub const LogAnomalyType = enum {
    keyword,
    keyword_token,
    format,
    http_code,
    block_format,
    numerical_point,
    numerical_nan,
    new_field_name,

    pub const json_field_names = .{
        .keyword = "KEYWORD",
        .keyword_token = "KEYWORD_TOKEN",
        .format = "FORMAT",
        .http_code = "HTTP_CODE",
        .block_format = "BLOCK_FORMAT",
        .numerical_point = "NUMERICAL_POINT",
        .numerical_nan = "NUMERICAL_NAN",
        .new_field_name = "NEW_FIELD_NAME",
    };
};
