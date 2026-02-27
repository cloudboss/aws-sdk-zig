/// The Amazon S3 location of the input data objects.
pub const LabelingJobS3DataSource = struct {
    /// The Amazon S3 location of the manifest file that describes the input data
    /// objects.
    ///
    /// The input manifest file referenced in `ManifestS3Uri` must contain one of
    /// the following keys: `source-ref` or `source`. The value of the keys are
    /// interpreted as follows:
    ///
    /// * `source-ref`: The source of the object is the Amazon S3 object specified
    ///   in the value. Use this value when the object is a binary object, such as
    ///   an image.
    /// * `source`: The source of the object is the value. Use this value when the
    ///   object is a text value.
    ///
    /// If you are a new user of Ground Truth, it is recommended you review [Use an
    /// Input Manifest File
    /// ](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-input-data-input-manifest.html) in the Amazon SageMaker Developer Guide to learn how to create an input manifest file.
    manifest_s3_uri: []const u8,

    pub const json_field_names = .{
        .manifest_s3_uri = "ManifestS3Uri",
    };
};
