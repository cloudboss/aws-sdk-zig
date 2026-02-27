/// Describes the annotations associated with a entity recognizer.
pub const EntityRecognizerAnnotations = struct {
    /// Specifies the Amazon S3 location where the annotations for an entity
    /// recognizer are
    /// located. The URI must be in the same Region as the API endpoint that you are
    /// calling.
    s3_uri: []const u8,

    /// Specifies the Amazon S3 location where the test annotations for an entity
    /// recognizer are
    /// located. The URI must be in the same Region as the API endpoint that you are
    /// calling.
    test_s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
        .test_s3_uri = "TestS3Uri",
    };
};
