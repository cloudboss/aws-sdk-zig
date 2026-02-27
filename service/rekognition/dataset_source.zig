const GroundTruthManifest = @import("ground_truth_manifest.zig").GroundTruthManifest;

/// The source that Amazon Rekognition Custom Labels uses to create a dataset.
/// To
/// use an Amazon Sagemaker format manifest file, specify the S3 bucket location
/// in the `GroundTruthManifest` field.
/// The S3 bucket must be in your AWS account.
/// To create a copy of an existing dataset, specify the Amazon Resource Name
/// (ARN) of
/// an existing dataset in `DatasetArn`.
///
/// You need to specify a value for `DatasetArn` or `GroundTruthManifest`, but
/// not both.
/// if you supply both values, or if you don't specify any values, an
/// InvalidParameterException exception occurs.
///
/// For more information, see CreateDataset.
pub const DatasetSource = struct {
    /// The ARN of an Amazon Rekognition Custom Labels dataset that you want to
    /// copy.
    dataset_arn: ?[]const u8,

    ground_truth_manifest: ?GroundTruthManifest,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
        .ground_truth_manifest = "GroundTruthManifest",
    };
};
