const ErrorCode = @import("error_code.zig").ErrorCode;

/// An object representing an error when an asynchronous operation fails.
pub const ErrorDetail = struct {
    /// A brief description of the error.
    ///
    /// * **SubnetNotFound**: We couldn't find one of the
    /// subnets associated with the cluster.
    ///
    /// * **SecurityGroupNotFound**: We couldn't find one
    /// of the security groups associated with the cluster.
    ///
    /// * **EniLimitReached**: You have reached the elastic
    /// network interface limit for your account.
    ///
    /// * **IpNotAvailable**: A subnet associated with the
    /// cluster doesn't have any available IP addresses.
    ///
    /// * **AccessDenied**: You don't have permissions to
    /// perform the specified operation.
    ///
    /// * **OperationNotPermitted**: The service role
    /// associated with the cluster doesn't have the required access permissions for
    /// Amazon EKS.
    ///
    /// * **VpcIdNotFound**: We couldn't find the VPC
    /// associated with the cluster.
    error_code: ?ErrorCode = null,

    /// A more complete description of the error.
    error_message: ?[]const u8 = null,

    /// An optional field that contains the resource IDs associated with the error.
    resource_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .resource_ids = "resourceIds",
    };
};
