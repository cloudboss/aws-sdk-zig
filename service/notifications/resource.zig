/// A resource affected by or closely linked to an event.
pub const Resource = struct {
    /// The Amazon Resource Name (ARN) of the resource. At least one id or ARN is
    /// required.
    arn: ?[]const u8 = null,

    /// The URL to the resource's detail page. If a detail page URL is unavailable,
    /// it is the URL to an informational page that describes the resource's type.
    detail_url: ?[]const u8 = null,

    /// The unique identifier for the resource.
    ///
    /// At least one id or ARN is required.
    id: ?[]const u8 = null,

    /// A map of tags assigned to a resource. A tag is a string-to-string map of
    /// key-value pairs.
    tags: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .detail_url = "detailUrl",
        .id = "id",
        .tags = "tags",
    };
};
