pub const UntagResourceRequest = struct {
    /// The ARN of the CloudWatch Logs resource that you're removing tags from.
    ///
    /// The ARN format of a log group is
    /// `arn:aws:logs:*Region*:*account-id*:log-group:*log-group-name*
    /// `
    ///
    /// The ARN format of a destination is
    /// `arn:aws:logs:*Region*:*account-id*:destination:*destination-name*
    /// `
    ///
    /// For more information about ARN format, see [CloudWatch Logs
    /// resources and
    /// operations](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/iam-access-control-overview-cwl.html).
    resource_arn: []const u8,

    /// The list of tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
