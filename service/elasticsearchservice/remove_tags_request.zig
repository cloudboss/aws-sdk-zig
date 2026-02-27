/// Container for the parameters to the `RemoveTags` operation. Specify the
/// `ARN` for the Elasticsearch domain from which you want to remove the
/// specified `TagKey`.
pub const RemoveTagsRequest = struct {
    /// Specifies the `ARN` for the Elasticsearch domain from which you want to
    /// delete the specified tags.
    arn: []const u8,

    /// Specifies the `TagKey` list which you want to remove from the Elasticsearch
    /// domain.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .tag_keys = "TagKeys",
    };
};
