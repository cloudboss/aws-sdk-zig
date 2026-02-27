/// Provides the Amazon Resource Name (ARN) of the Identity and Access
/// Management (IAM) role used to define an
/// Amazon DynamoDB target endpoint.
pub const DynamoDbSettings = struct {
    /// The Amazon Resource Name (ARN) used by the service to access the IAM role.
    /// The role
    /// must allow the `iam:PassRole` action.
    service_access_role_arn: []const u8,

    pub const json_field_names = .{
        .service_access_role_arn = "ServiceAccessRoleArn",
    };
};
