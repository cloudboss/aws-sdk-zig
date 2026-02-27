const AutoMLS3DataType = @import("auto_mls3_data_type.zig").AutoMLS3DataType;

/// Describes the Amazon S3 data source.
pub const AutoMLS3DataSource = struct {
    /// The data type.
    ///
    /// * If you choose `S3Prefix`, `S3Uri` identifies a key name prefix. SageMaker
    ///   AI uses all objects that match the specified key name prefix for model
    ///   training.
    ///
    /// The `S3Prefix` should have the following format:
    ///
    /// `s3://DOC-EXAMPLE-BUCKET/DOC-EXAMPLE-FOLDER-OR-FILE`
    /// * If you choose `ManifestFile`, `S3Uri` identifies an object that is a
    ///   manifest file containing a list of object keys that you want SageMaker AI
    ///   to use for model training.
    ///
    /// A `ManifestFile` should have the format shown below:
    ///
    /// `[ {"prefix":
    /// "s3://DOC-EXAMPLE-BUCKET/DOC-EXAMPLE-FOLDER/DOC-EXAMPLE-PREFIX/"}, `
    ///
    /// `"DOC-EXAMPLE-RELATIVE-PATH/DOC-EXAMPLE-FOLDER/DATA-1",`
    ///
    /// `"DOC-EXAMPLE-RELATIVE-PATH/DOC-EXAMPLE-FOLDER/DATA-2",`
    ///
    /// `... "DOC-EXAMPLE-RELATIVE-PATH/DOC-EXAMPLE-FOLDER/DATA-N" ]`
    /// * If you choose `AugmentedManifestFile`, `S3Uri` identifies an object that
    ///   is an augmented manifest file in JSON lines format. This file contains the
    ///   data you want to use for model training. `AugmentedManifestFile` is
    ///   available for V2 API jobs only (for example, for jobs created by calling
    ///   `CreateAutoMLJobV2`).
    ///
    /// Here is a minimal, single-record example of an `AugmentedManifestFile`:
    ///
    /// `{"source-ref": "s3://DOC-EXAMPLE-BUCKET/DOC-EXAMPLE-FOLDER/cats/cat.jpg",`
    ///
    /// `"label-metadata": {"class-name": "cat"` }
    ///
    /// For more information on `AugmentedManifestFile`, see [Provide Dataset
    /// Metadata to Training Jobs with an Augmented Manifest
    /// File](https://docs.aws.amazon.com/sagemaker/latest/dg/augmented-manifest.html).
    s3_data_type: AutoMLS3DataType,

    /// The URL to the Amazon S3 data source. The Uri refers to the Amazon S3 prefix
    /// or ManifestFile depending on the data type.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .s3_data_type = "S3DataType",
        .s3_uri = "S3Uri",
    };
};
