/// Contains the parameters for `UntagResource`.
pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource from which to delete tags.
    /// Batch resources that support tags are compute environments, jobs, job
    /// definitions, job queues,
    /// and scheduling policies. ARNs for child jobs of array and multi-node
    /// parallel (MNP) jobs aren't supported.
    resource_arn: []const u8,

    /// The keys of the tags to be removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
