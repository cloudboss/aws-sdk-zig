/// Information about a user whose limits could not be described in a batch
/// operation.
pub const BatchDescribeUserLimitsError = struct {
    /// The error code for the failure.
    error_code: []const u8,

    /// The error message for the failure.
    message: []const u8,

    /// The namespace of the user that failed.
    namespace: ?[]const u8 = null,

    /// The ARN of the user that failed.
    user_arn: ?[]const u8 = null,

    /// The name of the user that failed.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .message = "message",
        .namespace = "namespace",
        .user_arn = "userArn",
        .user_name = "userName",
    };
};
