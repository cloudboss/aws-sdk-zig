pub const VectorEnrichmentJobErrorType = enum {
    /// CLIENT_ERROR
    client_error,
    /// SERVER_ERROR
    server_error,

    pub const json_field_names = .{
        .client_error = "CLIENT_ERROR",
        .server_error = "SERVER_ERROR",
    };
};
