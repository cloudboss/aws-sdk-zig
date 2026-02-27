const CognitoGroupConfiguration = @import("cognito_group_configuration.zig").CognitoGroupConfiguration;

/// The configuration for an identity source that represents a connection to an
/// Amazon Cognito user pool used as an identity provider for Verified
/// Permissions.
///
/// This data type part of a
/// [Configuration](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_Configuration.html) structure that is used as a parameter to [CreateIdentitySource](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreateIdentitySource.html).
///
/// Example:`"CognitoUserPoolConfiguration":{"UserPoolArn":"arn:aws:cognito-idp:us-east-1:123456789012:userpool/us-east-1_1a2b3c4d5","ClientIds": ["a1b2c3d4e5f6g7h8i9j0kalbmc"],"groupConfiguration": {"groupEntityType": "MyCorp::Group"}}`
pub const CognitoUserPoolConfiguration = struct {
    /// The unique application client IDs that are associated with the specified
    /// Amazon Cognito user pool.
    ///
    /// Example: `"ClientIds": ["&ExampleCogClientId;"]`
    client_ids: ?[]const []const u8,

    /// The type of entity that a policy store maps to groups from an Amazon Cognito
    /// user pool identity source.
    group_configuration: ?CognitoGroupConfiguration,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the Amazon Cognito user pool that contains the identities to be authorized.
    ///
    /// Example: `"UserPoolArn":
    /// "arn:aws:cognito-idp:us-east-1:123456789012:userpool/us-east-1_1a2b3c4d5"`
    user_pool_arn: []const u8,

    pub const json_field_names = .{
        .client_ids = "clientIds",
        .group_configuration = "groupConfiguration",
        .user_pool_arn = "userPoolArn",
    };
};
