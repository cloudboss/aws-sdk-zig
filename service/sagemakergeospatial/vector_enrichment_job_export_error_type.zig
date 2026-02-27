pub const VectorEnrichmentJobExportErrorType = enum {
    client_error,
    server_error,

    pub const json_field_names = .{
        .client_error = "CLIENT_ERROR",
        .server_error = "SERVER_ERROR",
    };
};
