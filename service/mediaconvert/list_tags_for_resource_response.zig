const ResourceTags = @import("resource_tags.zig").ResourceTags;

pub const ListTagsForResourceResponse = struct {
    /// The Amazon Resource Name (ARN) and tags for an AWS Elemental MediaConvert
    /// resource.
    resource_tags: ?ResourceTags,

    pub const json_field_names = .{
        .resource_tags = "ResourceTags",
    };
};
