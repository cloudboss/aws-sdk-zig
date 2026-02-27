/// Describes the dataset entity list for an entity recognizer model.
///
/// For more information on how the input file is formatted, see [Preparing
/// training
/// data](https://docs.aws.amazon.com/comprehend/latest/dg/prep-training-data-cer.html)
/// in the Comprehend Developer Guide.
pub const DatasetEntityRecognizerEntityList = struct {
    /// Specifies the Amazon S3 location where the entity list is located.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
