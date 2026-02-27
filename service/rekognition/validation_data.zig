const Asset = @import("asset.zig").Asset;

/// Contains the Amazon S3 bucket location of the validation data for a model
/// training job.
///
/// The validation data includes error information for individual JSON Lines in
/// the dataset.
/// For more information, see *Debugging a Failed Model Training* in the
/// Amazon Rekognition Custom Labels Developer Guide.
///
/// You get the `ValidationData` object for the training dataset
/// (TrainingDataResult)
/// and the test dataset (TestingDataResult) by calling DescribeProjectVersions.
///
/// The assets array contains a single Asset object.
/// The GroundTruthManifest field of the Asset object contains the S3 bucket
/// location of
/// the validation data.
pub const ValidationData = struct {
    /// The assets that comprise the validation data.
    assets: ?[]const Asset,

    pub const json_field_names = .{
        .assets = "Assets",
    };
};
