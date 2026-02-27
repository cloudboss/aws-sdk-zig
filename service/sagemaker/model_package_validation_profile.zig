const TransformJobDefinition = @import("transform_job_definition.zig").TransformJobDefinition;

/// Contains data, such as the inputs and targeted instance types that are used
/// in the process of validating the model package.
///
/// The data provided in the validation profile is made available to your buyers
/// on Amazon Web Services Marketplace.
pub const ModelPackageValidationProfile = struct {
    /// The name of the profile for the model package.
    profile_name: []const u8,

    /// The `TransformJobDefinition` object that describes the transform job used
    /// for the validation of the model package.
    transform_job_definition: TransformJobDefinition,

    pub const json_field_names = .{
        .profile_name = "ProfileName",
        .transform_job_definition = "TransformJobDefinition",
    };
};
