const DocumentReaderConfig = @import("document_reader_config.zig").DocumentReaderConfig;
const InputFormat = @import("input_format.zig").InputFormat;

/// The input properties for an inference job. The document reader config field
/// applies
/// only to non-text inputs for custom analysis.
pub const InputDataConfig = struct {
    /// Provides configuration parameters to override the default actions for
    /// extracting text
    /// from PDF documents and image files.
    document_reader_config: ?DocumentReaderConfig,

    /// Specifies how the text in an input file should be processed:
    ///
    /// * `ONE_DOC_PER_FILE` - Each file is considered a separate document. Use
    /// this option when you are processing large documents, such as newspaper
    /// articles or
    /// scientific papers.
    ///
    /// * `ONE_DOC_PER_LINE` - Each line in a file is considered a separate
    /// document. Use this option when you are processing many short documents, such
    /// as text
    /// messages.
    input_format: ?InputFormat,

    /// The Amazon S3 URI for the input data. The URI must be in same Region as the
    /// API
    /// endpoint that you are calling. The URI can point to a single input file or
    /// it can provide the
    /// prefix for a collection of data files.
    ///
    /// For example, if you use the URI `S3://bucketName/prefix`, if the prefix is a
    /// single file, Amazon Comprehend uses that file as input. If more than one
    /// file begins with the
    /// prefix, Amazon Comprehend uses all of them as input.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .document_reader_config = "DocumentReaderConfig",
        .input_format = "InputFormat",
        .s3_uri = "S3Uri",
    };
};
