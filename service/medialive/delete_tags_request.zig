/// Placeholder documentation for DeleteTagsRequest
pub const DeleteTagsRequest = struct {
    resource_arn: []const u8,

    /// An array of tag keys to delete
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
