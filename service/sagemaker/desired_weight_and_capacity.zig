const ProductionVariantServerlessUpdateConfig = @import("production_variant_serverless_update_config.zig").ProductionVariantServerlessUpdateConfig;

/// Specifies weight and capacity values for a production variant.
pub const DesiredWeightAndCapacity = struct {
    /// The variant's capacity.
    desired_instance_count: ?i32 = null,

    /// The variant's weight.
    desired_weight: ?f32 = null,

    /// Specifies the serverless update concurrency configuration for an endpoint
    /// variant.
    serverless_update_config: ?ProductionVariantServerlessUpdateConfig = null,

    /// The name of the variant to update.
    variant_name: []const u8,

    pub const json_field_names = .{
        .desired_instance_count = "DesiredInstanceCount",
        .desired_weight = "DesiredWeight",
        .serverless_update_config = "ServerlessUpdateConfig",
        .variant_name = "VariantName",
    };
};
