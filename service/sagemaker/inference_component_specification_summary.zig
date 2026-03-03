const InferenceComponentComputeResourceRequirements = @import("inference_component_compute_resource_requirements.zig").InferenceComponentComputeResourceRequirements;
const InferenceComponentContainerSpecificationSummary = @import("inference_component_container_specification_summary.zig").InferenceComponentContainerSpecificationSummary;
const InferenceComponentDataCacheConfigSummary = @import("inference_component_data_cache_config_summary.zig").InferenceComponentDataCacheConfigSummary;
const InferenceComponentStartupParameters = @import("inference_component_startup_parameters.zig").InferenceComponentStartupParameters;

/// Details about the resources that are deployed with this inference component.
pub const InferenceComponentSpecificationSummary = struct {
    /// The name of the base inference component that contains this inference
    /// component.
    base_inference_component_name: ?[]const u8 = null,

    /// The compute resources allocated to run the model, plus any adapter models,
    /// that you assign to the inference component.
    compute_resource_requirements: ?InferenceComponentComputeResourceRequirements = null,

    /// Details about the container that provides the runtime environment for the
    /// model that is deployed with the inference component.
    container: ?InferenceComponentContainerSpecificationSummary = null,

    /// Settings that affect how the inference component caches data.
    data_cache_config: ?InferenceComponentDataCacheConfigSummary = null,

    /// The name of the SageMaker AI model object that is deployed with the
    /// inference component.
    model_name: ?[]const u8 = null,

    /// Settings that take effect while the model container starts up.
    startup_parameters: ?InferenceComponentStartupParameters = null,

    pub const json_field_names = .{
        .base_inference_component_name = "BaseInferenceComponentName",
        .compute_resource_requirements = "ComputeResourceRequirements",
        .container = "Container",
        .data_cache_config = "DataCacheConfig",
        .model_name = "ModelName",
        .startup_parameters = "StartupParameters",
    };
};
