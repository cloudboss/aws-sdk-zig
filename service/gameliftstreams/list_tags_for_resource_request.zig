pub const ListTagsForResourceRequest = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that you want to retrieve tags for. To get an Amazon GameLift Streams
    /// resource ARN, call a List or Get operation for the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
