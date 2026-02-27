/// Error info for scram secret associate/disassociate failure.
pub const UnprocessedScramSecret = struct {
    /// Error code for associate/disassociate failure.
    error_code: ?[]const u8,

    /// Error message for associate/disassociate failure.
    error_message: ?[]const u8,

    /// AWS Secrets Manager secret ARN.
    secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .secret_arn = "SecretArn",
    };
};
