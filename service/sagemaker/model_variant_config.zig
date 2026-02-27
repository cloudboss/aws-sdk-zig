const ModelInfrastructureConfig = @import("model_infrastructure_config.zig").ModelInfrastructureConfig;

/// Contains information about the deployment options of a model.
pub const ModelVariantConfig = struct {
    /// The configuration for the infrastructure that the model will be deployed to.
    infrastructure_config: ModelInfrastructureConfig,

    /// The name of the Amazon SageMaker Model entity.
    model_name: []const u8,

    /// The name of the variant.
    variant_name: []const u8,

    pub const json_field_names = .{
        .infrastructure_config = "InfrastructureConfig",
        .model_name = "ModelName",
        .variant_name = "VariantName",
    };
};
