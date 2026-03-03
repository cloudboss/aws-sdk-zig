const SubtitleFormat = @import("subtitle_format.zig").SubtitleFormat;

/// Provides information about your subtitle file, including format, start
/// index, and
/// Amazon S3 location.
pub const SubtitlesOutput = struct {
    /// Provides the format of your subtitle files. If your request included both
    /// WebVTT
    /// (`vtt`) and SubRip (`srt`) formats, both formats are
    /// shown.
    formats: ?[]const SubtitleFormat = null,

    /// Provides the start index value for your subtitle files. If you did not
    /// specify a value
    /// in your request, the default value of `0` is used.
    output_start_index: ?i32 = null,

    /// The Amazon S3 location of your transcript. You can use this URI to access or
    /// download your subtitle file. Your subtitle file is stored in the same
    /// location as your
    /// transcript. If you specified both WebVTT and SubRip subtitle formats, two
    /// URIs are
    /// provided.
    ///
    /// If you included `OutputBucketName` in your transcription job request, this
    /// is the URI of that bucket. If you also included `OutputKey` in your request,
    /// your output is located in the path you specified in your request.
    ///
    /// If you didn't include `OutputBucketName` in your transcription job request,
    /// your subtitle file is stored in a service-managed bucket, and
    /// `TranscriptFileUri` provides you with a temporary URI you can use for
    /// secure access to your subtitle file.
    ///
    /// Temporary URIs for service-managed Amazon S3 buckets are only valid for 15
    /// minutes. If you get an `AccesDenied` error, you can get a new temporary
    /// URI by running a `GetTranscriptionJob` or
    /// `ListTranscriptionJob` request.
    subtitle_file_uris: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .formats = "Formats",
        .output_start_index = "OutputStartIndex",
        .subtitle_file_uris = "SubtitleFileUris",
    };
};
