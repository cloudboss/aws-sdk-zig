const ProductionVariantCapacityReservationSummary = @import("production_variant_capacity_reservation_summary.zig").ProductionVariantCapacityReservationSummary;
const ProductionVariantServerlessConfig = @import("production_variant_serverless_config.zig").ProductionVariantServerlessConfig;
const DeployedImage = @import("deployed_image.zig").DeployedImage;
const ProductionVariantManagedInstanceScaling = @import("production_variant_managed_instance_scaling.zig").ProductionVariantManagedInstanceScaling;
const ProductionVariantRoutingConfig = @import("production_variant_routing_config.zig").ProductionVariantRoutingConfig;
const ProductionVariantStatus = @import("production_variant_status.zig").ProductionVariantStatus;

/// Describes weight and capacities for a production variant associated with an
/// endpoint. If you sent a request to the `UpdateEndpointWeightsAndCapacities`
/// API and the endpoint status is `Updating`, you get different desired and
/// current values.
pub const ProductionVariantSummary = struct {
    /// Settings for the capacity reservation for the compute instances that
    /// SageMaker AI reserves for an endpoint.
    capacity_reservation_config: ?ProductionVariantCapacityReservationSummary,

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

    /// The number of instances requested in the
    /// `UpdateEndpointWeightsAndCapacities` request.
    desired_instance_count: ?i32,

    /// The serverless configuration requested for the endpoint update.
    desired_serverless_config: ?ProductionVariantServerlessConfig,

    /// The requested weight, as specified in the
    /// `UpdateEndpointWeightsAndCapacities` request.
    desired_weight: ?f32,

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
        .capacity_reservation_config = "CapacityReservationConfig",
        .current_instance_count = "CurrentInstanceCount",
        .current_serverless_config = "CurrentServerlessConfig",
        .current_weight = "CurrentWeight",
        .deployed_images = "DeployedImages",
        .desired_instance_count = "DesiredInstanceCount",
        .desired_serverless_config = "DesiredServerlessConfig",
        .desired_weight = "DesiredWeight",
        .managed_instance_scaling = "ManagedInstanceScaling",
        .routing_config = "RoutingConfig",
        .variant_name = "VariantName",
        .variant_status = "VariantStatus",
    };
};
