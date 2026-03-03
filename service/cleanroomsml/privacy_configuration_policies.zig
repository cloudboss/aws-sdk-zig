const TrainedModelExportsConfigurationPolicy = @import("trained_model_exports_configuration_policy.zig").TrainedModelExportsConfigurationPolicy;
const TrainedModelInferenceJobsConfigurationPolicy = @import("trained_model_inference_jobs_configuration_policy.zig").TrainedModelInferenceJobsConfigurationPolicy;
const TrainedModelsConfigurationPolicy = @import("trained_models_configuration_policy.zig").TrainedModelsConfigurationPolicy;

/// Information about the privacy configuration policies for a configured model
/// algorithm association.
pub const PrivacyConfigurationPolicies = struct {
    /// Specifies who will receive the trained model export.
    trained_model_exports: ?TrainedModelExportsConfigurationPolicy = null,

    /// Specifies who will receive the trained model inference jobs.
    trained_model_inference_jobs: ?TrainedModelInferenceJobsConfigurationPolicy = null,

    /// Specifies who will receive the trained models.
    trained_models: ?TrainedModelsConfigurationPolicy = null,

    pub const json_field_names = .{
        .trained_model_exports = "trainedModelExports",
        .trained_model_inference_jobs = "trainedModelInferenceJobs",
        .trained_models = "trainedModels",
    };
};
