pub const VpcEndpointErrorCode = enum {
    endpoint_not_found,
    server_error,

    pub const json_field_names = .{
        .endpoint_not_found = "ENDPOINT_NOT_FOUND",
        .server_error = "SERVER_ERROR",
    };
};
