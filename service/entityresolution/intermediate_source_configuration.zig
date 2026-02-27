/// The Amazon S3 location that temporarily stores your data while it processes.
/// Your information won't be saved permanently.
pub const IntermediateSourceConfiguration = struct {
    /// The Amazon S3 location (bucket and prefix). For example:
    /// `s3://provider_bucket/DOC-EXAMPLE-BUCKET`
    intermediate_s3_path: []const u8,

    pub const json_field_names = .{
        .intermediate_s3_path = "intermediateS3Path",
    };
};
