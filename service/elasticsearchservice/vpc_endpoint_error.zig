const VpcEndpointErrorCode = @import("vpc_endpoint_error_code.zig").VpcEndpointErrorCode;

/// Error information when attempting to describe an Amazon OpenSearch
/// Service-managed VPC
/// endpoint.
pub const VpcEndpointError = struct {
    /// The code associated with the error.
    error_code: ?VpcEndpointErrorCode = null,

    /// A message describing the error.
    error_message: ?[]const u8 = null,

    /// The unique identifier of the endpoint.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};
