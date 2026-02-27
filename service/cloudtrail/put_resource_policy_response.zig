pub const PutResourcePolicyResponse = struct {
    /// The default resource-based policy that is automatically generated for the
    /// delegated administrator of an Organizations organization.
    /// This policy will be evaluated in tandem with any policy you submit for the
    /// resource. For more information about this policy,
    /// see [Default resource policy for delegated
    /// administrators](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-lake-organizations.html#cloudtrail-lake-organizations-eds-rbp).
    delegated_admin_resource_policy: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the CloudTrail event data store,
    /// dashboard, or channel attached to the resource-based policy.
    ///
    /// Example event data store ARN format:
    /// `arn:aws:cloudtrail:us-east-2:123456789012:eventdatastore/EXAMPLE-f852-4e8f-8bd1-bcf6cEXAMPLE`
    ///
    /// Example dashboard ARN format:
    /// `arn:aws:cloudtrail:us-east-1:123456789012:dashboard/exampleDash`
    ///
    /// Example channel ARN format:
    /// `arn:aws:cloudtrail:us-east-2:123456789012:channel/01234567890`
    resource_arn: ?[]const u8,

    /// The JSON-formatted string of the Amazon Web Services resource-based policy
    /// attached to the CloudTrail event data store, dashboard, or channel.
    resource_policy: ?[]const u8,

    pub const json_field_names = .{
        .delegated_admin_resource_policy = "DelegatedAdminResourcePolicy",
        .resource_arn = "ResourceArn",
        .resource_policy = "ResourcePolicy",
    };
};
