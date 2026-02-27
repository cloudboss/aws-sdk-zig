/// Describes the Amazon S3 location of the media file you want to use in your
/// request.
///
/// For information on supported media formats, refer to the `MediaFormat`
/// parameter or the [Media
/// formats](https://docs.aws.amazon.com/transcribe/latest/dg/how-input.html#how-input-audio) section
/// in the Amazon S3 Developer Guide.
pub const Media = struct {
    /// The Amazon S3 location of the media file you want to transcribe. For
    /// example:
    ///
    /// * `s3://DOC-EXAMPLE-BUCKET/my-media-file.flac`
    ///
    /// * `s3://DOC-EXAMPLE-BUCKET/media-files/my-media-file.flac`
    ///
    /// Note that the Amazon S3 bucket that contains your input media must be
    /// located
    /// in the same Amazon Web Services Region where you're making your
    /// transcription
    /// request.
    media_file_uri: ?[]const u8,

    /// The Amazon S3 location of the media file you want to redact. For
    /// example:
    ///
    /// * `s3://DOC-EXAMPLE-BUCKET/my-media-file.flac`
    ///
    /// * `s3://DOC-EXAMPLE-BUCKET/media-files/my-media-file.flac`
    ///
    /// Note that the Amazon S3 bucket that contains your input media must be
    /// located
    /// in the same Amazon Web Services Region where you're making your
    /// transcription
    /// request.
    ///
    /// `RedactedMediaFileUri` produces a redacted audio file in addition to a
    /// redacted transcript. It is only supported for Call Analytics
    /// (`StartCallAnalyticsJob`) transcription requests.
    redacted_media_file_uri: ?[]const u8,

    pub const json_field_names = .{
        .media_file_uri = "MediaFileUri",
        .redacted_media_file_uri = "RedactedMediaFileUri",
    };
};
