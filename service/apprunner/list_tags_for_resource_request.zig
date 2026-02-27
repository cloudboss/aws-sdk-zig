pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that a tag list is requested
    /// for.
    ///
    /// It must be the ARN of an App Runner resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
