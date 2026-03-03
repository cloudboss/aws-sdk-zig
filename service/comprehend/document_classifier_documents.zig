/// The location of the training documents. This parameter is required in a
/// request to create a semi-structured document classification model.
pub const DocumentClassifierDocuments = struct {
    /// The S3 URI location of the training documents specified in the S3Uri CSV
    /// file.
    s3_uri: []const u8,

    /// The S3 URI location of the test documents included in the TestS3Uri CSV
    /// file.
    /// This field is not required if you do not specify a test CSV file.
    test_s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
        .test_s3_uri = "TestS3Uri",
    };
};
