const InputFormat = @import("input_format.zig").InputFormat;

/// Describes the training documents submitted with an entity recognizer.
pub const EntityRecognizerDocuments = struct {
    /// Specifies how the text in an input file should be processed. This is
    /// optional, and the
    /// default is ONE_DOC_PER_LINE. ONE_DOC_PER_FILE - Each file is considered a
    /// separate document.
    /// Use this option when you are processing large documents, such as newspaper
    /// articles or
    /// scientific papers. ONE_DOC_PER_LINE - Each line in a file is considered a
    /// separate document.
    /// Use this option when you are processing many short documents, such as text
    /// messages.
    input_format: ?InputFormat,

    /// Specifies the Amazon S3 location where the training documents for an entity
    /// recognizer
    /// are located. The URI must be in the same Region as the API endpoint that you
    /// are
    /// calling.
    s3_uri: []const u8,

    /// Specifies the Amazon S3 location where the test documents for an entity
    /// recognizer are
    /// located. The URI must be in the same Amazon Web Services Region as the API
    /// endpoint that you are
    /// calling.
    test_s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .input_format = "InputFormat",
        .s3_uri = "S3Uri",
        .test_s3_uri = "TestS3Uri",
    };
};
