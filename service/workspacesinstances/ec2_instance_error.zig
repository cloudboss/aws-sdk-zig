/// Captures detailed error information for EC2 instance operations.
pub const EC2InstanceError = struct {
    /// Unique error code identifying the specific EC2 instance error.
    ec2_error_code: ?[]const u8 = null,

    /// Detailed description of the EC2 instance error.
    ec2_error_message: ?[]const u8 = null,

    /// Type of exception encountered during EC2 instance operation.
    ec2_exception_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .ec2_error_code = "EC2ErrorCode",
        .ec2_error_message = "EC2ErrorMessage",
        .ec2_exception_type = "EC2ExceptionType",
    };
};
