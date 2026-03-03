/// Error information for a failed `BatchGetVpcEndpoint` request.
pub const VpcEndpointErrorDetail = struct {
    /// The error code for the failed request.
    error_code: ?[]const u8 = null,

    /// An error message describing the reason for the failure.
    error_message: ?[]const u8 = null,

    /// The unique identifier of the VPC endpoint.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .id = "id",
    };
};
