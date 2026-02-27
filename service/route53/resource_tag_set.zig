const TagResourceType = @import("tag_resource_type.zig").TagResourceType;
const Tag = @import("tag.zig").Tag;

/// A complex type containing a resource and its associated tags.
pub const ResourceTagSet = struct {
    /// The ID for the specified resource.
    resource_id: ?[]const u8,

    /// The type of the resource.
    ///
    /// * The resource type for health checks is `healthcheck`.
    ///
    /// * The resource type for hosted zones is `hostedzone`.
    resource_type: ?TagResourceType,

    /// The tags associated with the specified resource.
    tags: ?[]const Tag,
};
