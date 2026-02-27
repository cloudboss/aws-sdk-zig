pub const ListTagsForResourceRequest = struct {
    /// Specify the ARN of the scalable target.
    ///
    /// For example:
    /// `arn:aws:application-autoscaling:us-east-1:123456789012:scalable-target/1234abcd56ab78cd901ef1234567890ab123`
    ///
    /// To get the ARN for a scalable target, use DescribeScalableTargets.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
