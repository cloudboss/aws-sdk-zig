pub const DeleteResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the CloudTrail event data store,
    /// dashboard, or channel you're deleting the resource-based policy from.
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

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
