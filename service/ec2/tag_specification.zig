const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// The tags to apply to a resource when the resource is being created. When you
/// specify a tag, you must
/// specify the resource type to tag, otherwise the request will fail.
///
/// The `Valid Values` lists all the resource types that can be tagged.
/// However, the action you're using might not support tagging all of these
/// resource types.
/// If you try to tag a resource type that is unsupported for the action you're
/// using,
/// you'll get an error.
pub const TagSpecification = struct {
    /// The type of resource to tag on creation.
    resource_type: ?ResourceType = null,

    /// The tags to apply to the resource.
    tags: ?[]const Tag = null,
};
