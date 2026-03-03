const HttpMethod = @import("http_method.zig").HttpMethod;

/// The configurations used for HTTPS subscriber notification.
pub const HttpsNotificationConfiguration = struct {
    /// The key name for the notification subscription.
    authorization_api_key_name: ?[]const u8 = null,

    /// The key value for the notification subscription.
    authorization_api_key_value: ?[]const u8 = null,

    /// The subscription endpoint in Security Lake. If you prefer notification with
    /// an HTTPs
    /// endpoint, populate this field.
    endpoint: []const u8,

    /// The HTTPS method used for the notification subscription.
    http_method: ?HttpMethod = null,

    /// The Amazon Resource Name (ARN) of the EventBridge API destinations IAM role
    /// that you
    /// created. For more information about ARNs and how to use them in policies,
    /// see [Managing data
    /// access](https://docs.aws.amazon.com//security-lake/latest/userguide/subscriber-data-access.html) and [Amazon Web Services
    /// Managed
    /// Policies](https://docs.aws.amazon.com/security-lake/latest/userguide/security-iam-awsmanpol.html) in the *Amazon Security Lake User Guide*.
    target_role_arn: []const u8,

    pub const json_field_names = .{
        .authorization_api_key_name = "authorizationApiKeyName",
        .authorization_api_key_value = "authorizationApiKeyValue",
        .endpoint = "endpoint",
        .http_method = "httpMethod",
        .target_role_arn = "targetRoleArn",
    };
};
