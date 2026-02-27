const Tag = @import("tag.zig").Tag;

pub const DescribeTagsResponse = struct {
    /// If the request included a `Marker`, the response returns that value in this
    /// field.
    marker: ?[]const u8,

    /// If a value is present, there are more tags to return. In a subsequent
    /// request, you can
    /// provide the value of `NextMarker` as the value of the `Marker` parameter
    /// in your next request to retrieve the next set of tags.
    next_marker: ?[]const u8,

    /// Returns tags associated with the file system as an array of `Tag` objects.
    tags: []const Tag,

    pub const json_field_names = .{
        .marker = "Marker",
        .next_marker = "NextMarker",
        .tags = "Tags",
    };
};
