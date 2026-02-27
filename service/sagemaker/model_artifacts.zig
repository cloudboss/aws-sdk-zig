/// Provides information about the location that is configured for storing model
/// artifacts.
///
/// Model artifacts are outputs that result from training a model. They
/// typically consist of trained parameters, a model definition that describes
/// how to compute inferences, and other metadata. A SageMaker container stores
/// your trained model artifacts in the `/opt/ml/model` directory. After
/// training has completed, by default, these artifacts are uploaded to your
/// Amazon S3 bucket as compressed files.
pub const ModelArtifacts = struct {
    /// The path of the S3 object that contains the model artifacts. For example,
    /// `s3://bucket-name/keynameprefix/model.tar.gz`.
    s3_model_artifacts: []const u8,

    pub const json_field_names = .{
        .s3_model_artifacts = "S3ModelArtifacts",
    };
};
