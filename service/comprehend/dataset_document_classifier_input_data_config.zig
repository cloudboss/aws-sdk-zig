/// Describes the dataset input data configuration for a document classifier
/// model.
///
/// For more information on how the input file is formatted, see [Preparing
/// training
/// data](https://docs.aws.amazon.com/comprehend/latest/dg/prep-classifier-data.html)
/// in the Comprehend Developer Guide.
pub const DatasetDocumentClassifierInputDataConfig = struct {
    /// Indicates the delimiter used to separate each label for training a
    /// multi-label classifier.
    /// The default delimiter between labels is a pipe (|). You can use a different
    /// character as a
    /// delimiter (if it's an allowed character) by specifying it under Delimiter
    /// for labels. If the
    /// training documents use a delimiter other than the default or the delimiter
    /// you specify, the
    /// labels on that line will be combined to make a single unique label, such as
    /// LABELLABELLABEL.
    label_delimiter: ?[]const u8,

    /// The Amazon S3 URI for the input data. The S3 bucket must be in the same
    /// Region as the API
    /// endpoint that you are calling. The URI can point to a single input file or
    /// it can provide the
    /// prefix for a collection of input files.
    ///
    /// For example, if you use the URI `S3://bucketName/prefix`, if the prefix is a
    /// single file, Amazon Comprehend uses that file as input. If more than one
    /// file begins with the
    /// prefix, Amazon Comprehend uses all of them as input.
    ///
    /// This parameter is required if you set `DataFormat` to
    /// `COMPREHEND_CSV`.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .label_delimiter = "LabelDelimiter",
        .s3_uri = "S3Uri",
    };
};
