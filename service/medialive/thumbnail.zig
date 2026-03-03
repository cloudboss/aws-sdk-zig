const ThumbnailType = @import("thumbnail_type.zig").ThumbnailType;

/// Details of a single thumbnail
pub const Thumbnail = struct {
    /// The binary data for the latest thumbnail.
    body: ?[]const u8 = null,

    /// The content type for the latest thumbnail.
    content_type: ?[]const u8 = null,

    /// Thumbnail Type
    thumbnail_type: ?ThumbnailType = null,

    /// Time stamp for the latest thumbnail.
    time_stamp: ?i64 = null,

    pub const json_field_names = .{
        .body = "Body",
        .content_type = "ContentType",
        .thumbnail_type = "ThumbnailType",
        .time_stamp = "TimeStamp",
    };
};
