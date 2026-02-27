pub const ListTagsForResourceRequest = struct {
    /// Amazon Resource Name (ARN) of the model, collection, or stream processor
    /// that contains
    /// the tags that you want a list of.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
