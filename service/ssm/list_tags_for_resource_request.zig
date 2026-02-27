const ResourceTypeForTagging = @import("resource_type_for_tagging.zig").ResourceTypeForTagging;

pub const ListTagsForResourceRequest = struct {
    /// The resource ID for which you want to see a list of tags.
    resource_id: []const u8,

    /// Returns a list of tags for a specific resource type.
    resource_type: ResourceTypeForTagging,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
