/// Contains the parameters for `ListTagsForResource`.
pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that identifies the resource that tags are
    /// listed for. Batch resources that support tags are compute environments,
    /// jobs, job definitions, job queues,
    /// and scheduling policies. ARNs for child jobs of array and multi-node
    /// parallel (MNP) jobs aren't supported.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
