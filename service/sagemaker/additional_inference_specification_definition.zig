const ModelPackageContainerDefinition = @import("model_package_container_definition.zig").ModelPackageContainerDefinition;
const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;
const TransformInstanceType = @import("transform_instance_type.zig").TransformInstanceType;

/// A structure of additional Inference Specification. Additional Inference
/// Specification specifies details about inference jobs that can be run with
/// models based on this model package
pub const AdditionalInferenceSpecificationDefinition = struct {
    /// The Amazon ECR registry path of the Docker image that contains the inference
    /// code.
    containers: []const ModelPackageContainerDefinition,

    /// A description of the additional Inference specification
    description: ?[]const u8,

    /// A unique name to identify the additional inference specification. The name
    /// must be unique within the list of your additional inference specifications
    /// for a particular model package.
    name: []const u8,

    /// The supported MIME types for the input data.
    supported_content_types: ?[]const []const u8,

    /// A list of the instance types that are used to generate inferences in
    /// real-time.
    supported_realtime_inference_instance_types: ?[]const ProductionVariantInstanceType,

    /// The supported MIME types for the output data.
    supported_response_mime_types: ?[]const []const u8,

    /// A list of the instance types on which a transformation job can be run or on
    /// which an endpoint can be deployed.
    supported_transform_instance_types: ?[]const TransformInstanceType,

    pub const json_field_names = .{
        .containers = "Containers",
        .description = "Description",
        .name = "Name",
        .supported_content_types = "SupportedContentTypes",
        .supported_realtime_inference_instance_types = "SupportedRealtimeInferenceInstanceTypes",
        .supported_response_mime_types = "SupportedResponseMIMETypes",
        .supported_transform_instance_types = "SupportedTransformInstanceTypes",
    };
};
