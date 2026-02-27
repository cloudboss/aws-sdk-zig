const DefaultAction = @import("default_action.zig").DefaultAction;

/// Describes an Amazon Cognito user pool configuration.
pub const UserPoolConfig = struct {
    /// A regular expression for validating the incoming Amazon Cognito user pool
    /// app client
    /// ID. If this value isn't set, no filtering is applied.
    app_id_client_regex: ?[]const u8,

    /// The Amazon Web Services Region in which the user pool was created.
    aws_region: []const u8,

    /// The action that you want your GraphQL API to take when a request that uses
    /// Amazon Cognito user pool authentication doesn't match the Amazon Cognito
    /// user pool
    /// configuration.
    default_action: DefaultAction,

    /// The user pool ID.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .app_id_client_regex = "appIdClientRegex",
        .aws_region = "awsRegion",
        .default_action = "defaultAction",
        .user_pool_id = "userPoolId",
    };
};
