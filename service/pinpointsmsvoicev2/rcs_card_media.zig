/// The media content of a rich card, including the file URL, optional
/// thumbnail, and display height.
pub const RcsCardMedia = struct {
    /// The S3 URI of the media file for the card, in the format
    /// `s3://bucket-name/key`. Maximum 2000 characters.
    file_url: []const u8,

    /// The display height of the media in the card. Valid values are SHORT, MEDIUM,
    /// and TALL.
    height: ?[]const u8 = null,

    /// The S3 URI of an optional thumbnail image for the card media. Maximum 2000
    /// characters.
    thumbnail_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_url = "FileUrl",
        .height = "Height",
        .thumbnail_url = "ThumbnailUrl",
    };
};
