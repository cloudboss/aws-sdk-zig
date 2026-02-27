const TagInfoForResource = @import("tag_info_for_resource.zig").TagInfoForResource;

pub const ListTagsForResourceResponse = struct {
    next_marker: ?[]const u8,

    tag_info_for_resource: ?TagInfoForResource,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .tag_info_for_resource = "TagInfoForResource",
    };
};
