const ModelPackageValidationProfile = @import("model_package_validation_profile.zig").ModelPackageValidationProfile;

/// Specifies batch transform jobs that SageMaker runs to validate your model
/// package.
pub const ModelPackageValidationSpecification = struct {
    /// An array of `ModelPackageValidationProfile` objects, each of which specifies
    /// a batch transform job that SageMaker runs to validate your model package.
    validation_profiles: []const ModelPackageValidationProfile,

    /// The IAM roles to be used for the validation of the model package.
    validation_role: []const u8,

    pub const json_field_names = .{
        .validation_profiles = "ValidationProfiles",
        .validation_role = "ValidationRole",
    };
};
