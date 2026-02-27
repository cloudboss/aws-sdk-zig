pub const ErrorCode = enum {
    invalid_graph_arn,
    invalid_request_body,
    internal_error,

    pub const json_field_names = .{
        .invalid_graph_arn = "InvalidGraphArn",
        .invalid_request_body = "InvalidRequestBody",
        .internal_error = "InternalError",
    };
};
