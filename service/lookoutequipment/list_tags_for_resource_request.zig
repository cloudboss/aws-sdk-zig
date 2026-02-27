pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource (such as the dataset or
    /// model) that is
    /// the focus of the `ListTagsForResource` operation.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
