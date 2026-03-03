/// Provides you with the Amazon S3 URI you can use to access your
/// transcript.
pub const Transcript = struct {
    /// The Amazon S3 location of your redacted transcript. You can use this URI to
    /// access or download your transcript.
    ///
    /// If you included `OutputBucketName` in your transcription job request, this
    /// is the URI of that bucket. If you also included `OutputKey` in your request,
    /// your output is located in the path you specified in your request.
    ///
    /// If you didn't include `OutputBucketName` in your transcription job request,
    /// your transcript is stored in a service-managed bucket, and
    /// `RedactedTranscriptFileUri` provides you with a temporary URI you can use
    /// for secure access to your transcript.
    ///
    /// Temporary URIs for service-managed Amazon S3 buckets are only valid for 15
    /// minutes. If you get an `AccesDenied` error, you can get a new temporary
    /// URI by running a `GetTranscriptionJob` or
    /// `ListTranscriptionJob` request.
    redacted_transcript_file_uri: ?[]const u8 = null,

    /// The Amazon S3 location of your transcript. You can use this URI to access or
    /// download your transcript.
    ///
    /// If you included `OutputBucketName` in your transcription job request, this
    /// is the URI of that bucket. If you also included `OutputKey` in your request,
    /// your output is located in the path you specified in your request.
    ///
    /// If you didn't include `OutputBucketName` in your transcription job request,
    /// your transcript is stored in a service-managed bucket, and
    /// `TranscriptFileUri` provides you with a temporary URI you can use for
    /// secure access to your transcript.
    ///
    /// Temporary URIs for service-managed Amazon S3 buckets are only valid for 15
    /// minutes. If you get an `AccesDenied` error, you can get a new temporary
    /// URI by running a `GetTranscriptionJob` or
    /// `ListTranscriptionJob` request.
    transcript_file_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .redacted_transcript_file_uri = "RedactedTranscriptFileUri",
        .transcript_file_uri = "TranscriptFileUri",
    };
};
