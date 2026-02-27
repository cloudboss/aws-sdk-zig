pub const ErrorCode = enum {
    access_denied,
    internal_server_error,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };
};
