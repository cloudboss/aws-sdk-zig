const TagInfoForResource = @import("tag_info_for_resource.zig").TagInfoForResource;

pub const ListTagsForResourceResponse = struct {
    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available
    /// for retrieval exceeds the limit, WAF returns a `NextMarker`
    /// value in the response. To retrieve the next batch of objects, provide the
    /// marker from the prior call in your next request.
    next_marker: ?[]const u8,

    /// The collection of tagging definitions for the resource. If you specified a
    /// `Limit` in your request, this might not be the full list.
    tag_info_for_resource: ?TagInfoForResource,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .tag_info_for_resource = "TagInfoForResource",
    };
};
