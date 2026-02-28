/// Information about the entity that created the session.
pub const AwsIamAccessKeySessionContextSessionIssuer = struct {
    /// The identifier of the Amazon Web Services account that created the session.
    account_id: ?[]const u8,

    /// The ARN of the session.
    arn: ?[]const u8,

    /// The principal ID of the principal (user, role, or group) that created the
    /// session.
    principal_id: ?[]const u8,

    /// The type of principal (user, role, or group) that created the session.
    @"type": ?[]const u8,

    /// The name of the principal that created the session.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .arn = "Arn",
        .principal_id = "PrincipalId",
        .@"type" = "Type",
        .user_name = "UserName",
    };
};
