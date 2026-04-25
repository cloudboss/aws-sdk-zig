/// The Amazon S3 model source configuration.
pub const AIModelSourceS3 = struct {
    /// The Amazon S3 URI of the model artifacts.
    s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
