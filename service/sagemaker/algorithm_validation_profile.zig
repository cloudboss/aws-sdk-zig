const TrainingJobDefinition = @import("training_job_definition.zig").TrainingJobDefinition;
const TransformJobDefinition = @import("transform_job_definition.zig").TransformJobDefinition;

/// Defines a training job and a batch transform job that SageMaker runs to
/// validate your algorithm.
///
/// The data provided in the validation profile is made available to your buyers
/// on Amazon Web Services Marketplace.
pub const AlgorithmValidationProfile = struct {
    /// The name of the profile for the algorithm. The name must have 1 to 63
    /// characters. Valid characters are a-z, A-Z, 0-9, and - (hyphen).
    profile_name: []const u8,

    /// The `TrainingJobDefinition` object that describes the training job that
    /// SageMaker runs to validate your algorithm.
    training_job_definition: TrainingJobDefinition,

    /// The `TransformJobDefinition` object that describes the transform job that
    /// SageMaker runs to validate your algorithm.
    transform_job_definition: ?TransformJobDefinition = null,

    pub const json_field_names = .{
        .profile_name = "ProfileName",
        .training_job_definition = "TrainingJobDefinition",
        .transform_job_definition = "TransformJobDefinition",
    };
};
