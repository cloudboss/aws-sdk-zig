const TagResourceType = @import("tag_resource_type.zig").TagResourceType;

/// A complex type containing information about a request for a list of the tags
/// that are
/// associated with an individual resource.
pub const ListTagsForResourceRequest = struct {
    /// The ID of the resource for which you want to retrieve tags.
    resource_id: []const u8,

    /// The type of the resource.
    ///
    /// * The resource type for health checks is `healthcheck`.
    ///
    /// * The resource type for hosted zones is `hostedzone`.
    resource_type: TagResourceType,
};
