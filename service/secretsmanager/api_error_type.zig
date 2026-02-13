/// The error Secrets Manager encountered while retrieving an individual secret
/// as part of BatchGetSecretValue.
pub const APIErrorType = struct {
    /// The error Secrets Manager encountered while retrieving an individual secret
    /// as part of BatchGetSecretValue, for example
    /// `ResourceNotFoundException`,`InvalidParameterException`,
    /// `InvalidRequestException`, `DecryptionFailure`, or
    /// `AccessDeniedException`.
    error_code: ?[]const u8,

    /// A message describing the error.
    message: ?[]const u8,

    /// The ARN or name of the secret.
    secret_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
        .secret_id = "SecretId",
    };
};
