/// Specifies the error code of the failure encountered while describing the VPC
/// endpoint:
///
/// * ENDPOINT_NOT_FOUND: Indicates that the requested VPC endpoint does not
///   exist.
///
/// * SERVER_ERROR: Indicates the describe endpoint operation failed due to an
///   internal server error.
pub const VpcEndpointErrorCode = enum {
    endpoint_not_found,
    server_error,

    pub const json_field_names = .{
        .endpoint_not_found = "ENDPOINT_NOT_FOUND",
        .server_error = "SERVER_ERROR",
    };
};
