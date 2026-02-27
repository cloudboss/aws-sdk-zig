const UpdateCognitoGroupConfiguration = @import("update_cognito_group_configuration.zig").UpdateCognitoGroupConfiguration;

/// Contains configuration details of a Amazon Cognito user pool for use with an
/// identity source.
pub const UpdateCognitoUserPoolConfiguration = struct {
    /// The client ID of an app client that is configured for the specified Amazon
    /// Cognito user pool.
    client_ids: ?[]const []const u8,

    /// The configuration of the user groups from an Amazon Cognito user pool
    /// identity source.
    group_configuration: ?UpdateCognitoGroupConfiguration,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the Amazon Cognito user pool associated with this identity source.
    user_pool_arn: []const u8,

    pub const json_field_names = .{
        .client_ids = "clientIds",
        .group_configuration = "groupConfiguration",
        .user_pool_arn = "userPoolArn",
    };
};
