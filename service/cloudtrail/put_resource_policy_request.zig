pub const PutResourcePolicyRequest = struct {
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
    resource_arn: []const u8,

    /// A JSON-formatted string for an Amazon Web Services resource-based policy.
    ///
    /// For example resource-based policies, see
    /// [CloudTrail resource-based policy
    /// examples](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/security_iam_resource-based-policy-examples.html)
    /// in the *CloudTrail User Guide*.
    resource_policy: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_policy = "ResourcePolicy",
    };
};
