const ErrorCode = @import("error_code.zig").ErrorCode;

/// A list of failed member ARNs, error codes, and error messages.
pub const BatchCreateChannelMembershipError = struct {
    /// The error code.
    error_code: ?ErrorCode = null,

    /// The error message.
    error_message: ?[]const u8 = null,

    /// The `AppInstanceUserArn` of the member that the service couldn't add.
    member_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .member_arn = "MemberArn",
    };
};
