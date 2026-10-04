/// The media content of a carousel card. Display height is restricted to SHORT
/// or MEDIUM (TALL is not supported in carousels).
pub const RcsCarouselCardMedia = struct {
    /// The S3 URI of the media file for the carousel card. Maximum 2000 characters.
    file_url: []const u8,

    /// The display height of the media in the carousel card. Valid values are SHORT
    /// and MEDIUM.
    height: ?[]const u8 = null,

    /// The S3 URI of an optional thumbnail image for the carousel card media.
    /// Maximum 2000 characters.
    thumbnail_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_url = "FileUrl",
        .height = "Height",
        .thumbnail_url = "ThumbnailUrl",
    };
};
