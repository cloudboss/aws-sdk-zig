const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// Identifies the Application Auto Scaling scalable target that you want to
    /// apply tags to.
    ///
    /// For example:
    /// `arn:aws:application-autoscaling:us-east-1:123456789012:scalable-target/1234abcd56ab78cd901ef1234567890ab123`
    ///
    /// To get the ARN for a scalable target, use DescribeScalableTargets.
    resource_arn: []const u8,

    /// The tags assigned to the resource. A tag is a label that you assign to an
    /// Amazon Web Services
    /// resource.
    ///
    /// Each tag consists of a tag key and a tag value.
    ///
    /// You cannot have more than one tag on an Application Auto Scaling scalable
    /// target with the same tag key.
    /// If you specify an existing tag key with a different tag value, Application
    /// Auto Scaling replaces the
    /// current tag value with the specified one.
    ///
    /// For information about the rules that apply to tag keys and tag values, see
    /// [User-defined tag
    /// restrictions](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html) in the *Amazon Web Services Billing User Guide*.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
