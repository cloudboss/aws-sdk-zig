pub const UntagResourceRequest = struct {
    /// Identifies the Application Auto Scaling scalable target from which to remove
    /// tags.
    ///
    /// For example:
    /// `arn:aws:application-autoscaling:us-east-1:123456789012:scalable-target/1234abcd56ab78cd901ef1234567890ab123`
    ///
    /// To get the ARN for a scalable target, use DescribeScalableTargets.
    resource_arn: []const u8,

    /// One or more tag keys. Specify only the tag keys, not the tag values.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
