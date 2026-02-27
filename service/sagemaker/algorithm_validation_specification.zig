const AlgorithmValidationProfile = @import("algorithm_validation_profile.zig").AlgorithmValidationProfile;

/// Specifies configurations for one or more training jobs that SageMaker runs
/// to test the algorithm.
pub const AlgorithmValidationSpecification = struct {
    /// An array of `AlgorithmValidationProfile` objects, each of which specifies a
    /// training job and batch transform job that SageMaker runs to validate your
    /// algorithm.
    validation_profiles: []const AlgorithmValidationProfile,

    /// The IAM roles that SageMaker uses to run the training jobs.
    validation_role: []const u8,

    pub const json_field_names = .{
        .validation_profiles = "ValidationProfiles",
        .validation_role = "ValidationRole",
    };
};
