/// An embedded promotional video for a product.
pub const PromotionalEmbeddedVideo = struct {
    /// An optional description of the video.
    description: ?[]const u8 = null,

    /// The URL of the high-resolution preview image for the video.
    preview: []const u8,

    /// The URL of the thumbnail image for the video.
    thumbnail: []const u8,

    /// The title displayed when hovering over the video.
    title: []const u8,

    /// The URL of the video file.
    url: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .preview = "preview",
        .thumbnail = "thumbnail",
        .title = "title",
        .url = "url",
    };
};
