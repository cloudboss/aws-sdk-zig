const ModelPackageContainerDefinition = @import("model_package_container_definition.zig").ModelPackageContainerDefinition;
const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;
const TransformInstanceType = @import("transform_instance_type.zig").TransformInstanceType;

/// Defines how to perform inference generation after a training job is run.
pub const InferenceSpecification = struct {
    /// The Amazon ECR registry path of the Docker image that contains the inference
    /// code.
    containers: []const ModelPackageContainerDefinition,

    /// The supported MIME types for the input data.
    supported_content_types: ?[]const []const u8 = null,

    /// A list of the instance types that are used to generate inferences in
    /// real-time.
    ///
    /// This parameter is required for unversioned models, and optional for
    /// versioned models.
    supported_realtime_inference_instance_types: ?[]const ProductionVariantInstanceType = null,

    /// The supported MIME types for the output data.
    supported_response_mime_types: ?[]const []const u8 = null,

    /// A list of the instance types on which a transformation job can be run or on
    /// which an endpoint can be deployed.
    ///
    /// This parameter is required for unversioned models, and optional for
    /// versioned models.
    supported_transform_instance_types: ?[]const TransformInstanceType = null,

    pub const json_field_names = .{
        .containers = "Containers",
        .supported_content_types = "SupportedContentTypes",
        .supported_realtime_inference_instance_types = "SupportedRealtimeInferenceInstanceTypes",
        .supported_response_mime_types = "SupportedResponseMIMETypes",
        .supported_transform_instance_types = "SupportedTransformInstanceTypes",
    };
};
