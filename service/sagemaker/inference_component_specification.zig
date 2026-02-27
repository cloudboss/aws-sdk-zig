const InferenceComponentComputeResourceRequirements = @import("inference_component_compute_resource_requirements.zig").InferenceComponentComputeResourceRequirements;
const InferenceComponentContainerSpecification = @import("inference_component_container_specification.zig").InferenceComponentContainerSpecification;
const InferenceComponentDataCacheConfig = @import("inference_component_data_cache_config.zig").InferenceComponentDataCacheConfig;
const InferenceComponentStartupParameters = @import("inference_component_startup_parameters.zig").InferenceComponentStartupParameters;

/// Details about the resources to deploy with this inference component,
/// including the model, container, and compute resources.
pub const InferenceComponentSpecification = struct {
    /// The name of an existing inference component that is to contain the inference
    /// component that you're creating with your request.
    ///
    /// Specify this parameter only if your request is meant to create an adapter
    /// inference component. An adapter inference component contains the path to an
    /// adapter model. The purpose of the adapter model is to tailor the inference
    /// output of a base foundation model, which is hosted by the base inference
    /// component. The adapter inference component uses the compute resources that
    /// you assigned to the base inference component.
    ///
    /// When you create an adapter inference component, use the `Container`
    /// parameter to specify the location of the adapter artifacts. In the parameter
    /// value, use the `ArtifactUrl` parameter of the
    /// `InferenceComponentContainerSpecification` data type.
    ///
    /// Before you can create an adapter inference component, you must have an
    /// existing inference component that contains the foundation model that you
    /// want to adapt.
    base_inference_component_name: ?[]const u8,

    /// The compute resources allocated to run the model, plus any adapter models,
    /// that you assign to the inference component.
    ///
    /// Omit this parameter if your request is meant to create an adapter inference
    /// component. An adapter inference component is loaded by a base inference
    /// component, and it uses the compute resources of the base inference
    /// component.
    compute_resource_requirements: ?InferenceComponentComputeResourceRequirements,

    /// Defines a container that provides the runtime environment for a model that
    /// you deploy with an inference component.
    container: ?InferenceComponentContainerSpecification,

    /// Settings that affect how the inference component caches data.
    data_cache_config: ?InferenceComponentDataCacheConfig,

    /// The name of an existing SageMaker AI model object in your account that you
    /// want to deploy with the inference component.
    model_name: ?[]const u8,

    /// Settings that take effect while the model container starts up.
    startup_parameters: ?InferenceComponentStartupParameters,

    pub const json_field_names = .{
        .base_inference_component_name = "BaseInferenceComponentName",
        .compute_resource_requirements = "ComputeResourceRequirements",
        .container = "Container",
        .data_cache_config = "DataCacheConfig",
        .model_name = "ModelName",
        .startup_parameters = "StartupParameters",
    };
};
