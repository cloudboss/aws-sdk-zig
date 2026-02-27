pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that identifies the resource for which to
    /// list the tags. Currently, the
    /// only supported resource is an Amazon ECR repository.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
