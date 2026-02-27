const ResourceTagSet = @import("resource_tag_set.zig").ResourceTagSet;

/// A complex type that contains information about the health checks or hosted
/// zones for
/// which you want to list tags.
pub const ListTagsForResourceResponse = struct {
    /// A `ResourceTagSet` containing tags associated with the specified
    /// resource.
    resource_tag_set: ResourceTagSet,
};
