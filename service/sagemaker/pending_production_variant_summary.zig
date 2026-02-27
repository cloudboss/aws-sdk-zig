const ProductionVariantAcceleratorType = @import("production_variant_accelerator_type.zig").ProductionVariantAcceleratorType;
const ProductionVariantServerlessConfig = @import("production_variant_serverless_config.zig").ProductionVariantServerlessConfig;
const DeployedImage = @import("deployed_image.zig").DeployedImage;
const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;
const ProductionVariantManagedInstanceScaling = @import("production_variant_managed_instance_scaling.zig").ProductionVariantManagedInstanceScaling;
const ProductionVariantRoutingConfig = @import("production_variant_routing_config.zig").ProductionVariantRoutingConfig;
const ProductionVariantStatus = @import("production_variant_status.zig").ProductionVariantStatus;

/// The production variant summary for a deployment when an endpoint is creating
/// or updating with the
/// [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html) or [UpdateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpoint.html) operations. Describes the `VariantStatus `, weight and capacity for a production variant associated with an endpoint.
pub const PendingProductionVariantSummary = struct {
    /// This parameter is no longer supported. Elastic Inference (EI) is no longer
    /// available.
    ///
    /// This parameter was used to specify the size of the EI instance to use for
    /// the production variant.
    accelerator_type: ?ProductionVariantAcceleratorType,

    /// The number of instances associated with the variant.
    current_instance_count: ?i32,

    /// The serverless configuration for the endpoint.
    current_serverless_config: ?ProductionVariantServerlessConfig,

    /// The weight associated with the variant.
    current_weight: ?f32,

    /// An array of `DeployedImage` objects that specify the Amazon EC2 Container
    /// Registry paths of the inference images deployed on instances of this
    /// `ProductionVariant`.
    deployed_images: ?[]const DeployedImage,

    /// The number of instances requested in this deployment, as specified in the
    /// endpoint configuration for the endpoint. The value is taken from the request
    /// to the
    /// [CreateEndpointConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpointConfig.html) operation.
    desired_instance_count: ?i32,

    /// The serverless configuration requested for this deployment, as specified in
    /// the endpoint configuration for the endpoint.
    desired_serverless_config: ?ProductionVariantServerlessConfig,

    /// The requested weight for the variant in this deployment, as specified in the
    /// endpoint configuration for the endpoint. The value is taken from the request
    /// to the
    /// [CreateEndpointConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpointConfig.html) operation.
    desired_weight: ?f32,

    /// The type of instances associated with the variant.
    instance_type: ?ProductionVariantInstanceType,

    /// Settings that control the range in the number of instances that the endpoint
    /// provisions as it scales up or down to accommodate traffic.
    managed_instance_scaling: ?ProductionVariantManagedInstanceScaling,

    /// Settings that control how the endpoint routes incoming traffic to the
    /// instances that the endpoint hosts.
    routing_config: ?ProductionVariantRoutingConfig,

    /// The name of the variant.
    variant_name: []const u8,

    /// The endpoint variant status which describes the current deployment stage
    /// status or operational status.
    variant_status: ?[]const ProductionVariantStatus,

    pub const json_field_names = .{
        .accelerator_type = "AcceleratorType",
        .current_instance_count = "CurrentInstanceCount",
        .current_serverless_config = "CurrentServerlessConfig",
        .current_weight = "CurrentWeight",
        .deployed_images = "DeployedImages",
        .desired_instance_count = "DesiredInstanceCount",
        .desired_serverless_config = "DesiredServerlessConfig",
        .desired_weight = "DesiredWeight",
        .instance_type = "InstanceType",
        .managed_instance_scaling = "ManagedInstanceScaling",
        .routing_config = "RoutingConfig",
        .variant_name = "VariantName",
        .variant_status = "VariantStatus",
    };
};
