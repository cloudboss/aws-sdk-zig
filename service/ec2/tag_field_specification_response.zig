const TaggableResourceType = @import("taggable_resource_type.zig").TaggableResourceType;

/// A single resource's tag configuration associated with the Flow Logs Amazon
/// EC2 Tags feature fields in your custom log format.
pub const TagFieldSpecificationResponse = struct {
    /// The resource type for the tag keys associated with the Flow Logs Amazon EC2
    /// Tags feature fields in your custom log format.
    resource_type: ?TaggableResourceType = null,

    /// The tag keys on your tagged resources to be displayed by the Flow Logs
    /// Amazon EC2 Tags feature fields in your custom log format.
    tag_keys: ?[]const []const u8 = null,
};
