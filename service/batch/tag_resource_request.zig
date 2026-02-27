const aws = @import("aws");

/// Contains the parameters for `TagResource`.
pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that tags are added to. Batch
    /// resources that support tags are compute environments, jobs, job definitions,
    /// job queues,
    /// and scheduling policies. ARNs for child jobs of array and multi-node
    /// parallel (MNP) jobs aren't supported.
    resource_arn: []const u8,

    /// The tags that you apply to the resource to help you categorize and organize
    /// your
    /// resources. Each tag consists of a key and an optional value. For more
    /// information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in *Amazon Web Services General Reference*.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
