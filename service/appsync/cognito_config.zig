/// Describes an Amazon Cognito configuration.
pub const CognitoConfig = struct {
    /// A regular expression for validating the incoming Amazon Cognito user pool
    /// app client
    /// ID. If this value isn't set, no filtering is applied.
    app_id_client_regex: ?[]const u8 = null,

    /// The Amazon Web Services Region in which the user pool was created.
    aws_region: []const u8,

    /// The user pool ID.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .app_id_client_regex = "appIdClientRegex",
        .aws_region = "awsRegion",
        .user_pool_id = "userPoolId",
    };
};
