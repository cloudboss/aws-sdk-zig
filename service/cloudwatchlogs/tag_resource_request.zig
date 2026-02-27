const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource that you're adding tags to.
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

    /// The list of key-value pairs to associate with the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
