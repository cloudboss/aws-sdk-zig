pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that identifies the resource to list the tags
    /// for. Currently, the supported resources are Amazon ECS tasks, services, task
    /// definitions, clusters, and container instances.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
