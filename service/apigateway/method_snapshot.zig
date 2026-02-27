/// Represents a summary of a Method resource, given a particular date and time.
pub const MethodSnapshot = struct {
    /// Specifies whether the method requires a valid ApiKey.
    api_key_required: bool = false,

    /// The method's authorization type. Valid values are `NONE` for open access,
    /// `AWS_IAM` for using AWS IAM permissions, `CUSTOM` for using a custom
    /// authorizer, or `COGNITO_USER_POOLS` for using a Cognito user pool.
    authorization_type: ?[]const u8,

    pub const json_field_names = .{
        .api_key_required = "apiKeyRequired",
        .authorization_type = "authorizationType",
    };
};
