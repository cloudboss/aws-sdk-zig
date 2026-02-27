pub const TcpRetryPolicyEvent = enum {
    connection_error,

    pub const json_field_names = .{
        .connection_error = "CONNECTION_ERROR",
    };
};
