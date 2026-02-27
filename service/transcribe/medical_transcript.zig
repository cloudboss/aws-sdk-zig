/// Provides you with the Amazon S3 URI you can use to access your
/// transcript.
pub const MedicalTranscript = struct {
    /// The Amazon S3 location of your transcript. You can use this URI to access or
    /// download your transcript.
    ///
    /// Note that this is the Amazon S3 location you specified in your request using
    /// the
    /// `OutputBucketName` parameter.
    transcript_file_uri: ?[]const u8,

    pub const json_field_names = .{
        .transcript_file_uri = "TranscriptFileUri",
    };
};
