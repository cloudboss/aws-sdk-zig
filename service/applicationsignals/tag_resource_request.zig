const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch resource that you want to
    /// set tags for.
    ///
    /// The ARN format of an Application Signals SLO is
    /// `arn:aws:cloudwatch:*Region*:*account-id*:slo:*slo-name* `
    ///
    /// For more information about ARN format, see [ Resource Types Defined by
    /// Amazon
    /// CloudWatch](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatch.html#amazoncloudwatch-resources-for-iam-policies) in the *Amazon Web Services General Reference*.
    resource_arn: []const u8,

    /// The list of key-value pairs to associate with the alarm.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
