pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch resource that you want to
    /// delete tags from.
    ///
    /// The ARN format of an Application Signals SLO is
    /// `arn:aws:cloudwatch:*Region*:*account-id*:slo:*slo-name* `
    ///
    /// For more information about ARN format, see [ Resource Types Defined by
    /// Amazon
    /// CloudWatch](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatch.html#amazoncloudwatch-resources-for-iam-policies) in the *Amazon Web Services General Reference*.
    resource_arn: []const u8,

    /// The list of tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
