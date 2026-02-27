pub const FailureCode = enum {
    client_error,
    server_fault,

    pub const json_field_names = .{
        .client_error = "ClientError",
        .server_fault = "ServerFault",
    };
};
