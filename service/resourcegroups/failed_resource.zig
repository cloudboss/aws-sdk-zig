/// A resource that failed to be added to or removed from a group.
pub const FailedResource = struct {
    /// The error code associated with the failure.
    error_code: ?[]const u8 = null,

    /// The error message text associated with the failure.
    error_message: ?[]const u8 = null,

    /// The Amazon resource name (ARN) of the resource that failed to be added or
    /// removed.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .resource_arn = "ResourceArn",
    };
};
