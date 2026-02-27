/// Information on the identity that created the file.
pub const CreatedByInfo = union(enum) {
    /// STS or IAM ARN representing the identity of API Caller. SDK users cannot
    /// populate this and this value is
    /// calculated automatically if `ConnectUserArn` is not provided.
    aws_identity_arn: ?[]const u8,
    /// An agent ARN representing a [connect
    /// user](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonconnect.html#amazonconnect-resources-for-iam-policies).
    connect_user_arn: ?[]const u8,

    pub const json_field_names = .{
        .aws_identity_arn = "AWSIdentityArn",
        .connect_user_arn = "ConnectUserArn",
    };
};
