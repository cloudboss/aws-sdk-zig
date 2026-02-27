pub const ListTagsForResourceRequest = struct {
    /// The Amazon resource number (ARN) of the resource to list tags of.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
