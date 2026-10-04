/// A file message containing a media file (image, video, audio, or PDF) with an
/// optional thumbnail.
pub const RcsFileMessage = struct {
    /// The S3 URI of the media file to send, in the format `s3://bucket-name/key`.
    /// The service downloads the file from your S3 bucket, rehosts it, and
    /// generates a presigned URL for the aggregator. Maximum 2000 characters.
    file_url: []const u8,

    /// The S3 URI of an optional thumbnail image for the media file, in the format
    /// `s3://bucket-name/key`. Maximum 2000 characters.
    thumbnail_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_url = "FileUrl",
        .thumbnail_url = "ThumbnailUrl",
    };
};
