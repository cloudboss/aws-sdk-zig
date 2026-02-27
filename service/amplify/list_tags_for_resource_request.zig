/// The request structure to use to list tags for a resource.
pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) to use to list tags.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
