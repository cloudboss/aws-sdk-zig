const ModelInfrastructureConfig = @import("model_infrastructure_config.zig").ModelInfrastructureConfig;
const ModelVariantStatus = @import("model_variant_status.zig").ModelVariantStatus;

/// Summary of the deployment configuration of a model.
pub const ModelVariantConfigSummary = struct {
    /// The configuration of the infrastructure that the model has been deployed to.
    infrastructure_config: ModelInfrastructureConfig,

    /// The name of the Amazon SageMaker Model entity.
    model_name: []const u8,

    /// The status of deployment for the model variant on the hosted inference
    /// endpoint.
    ///
    /// * `Creating` - Amazon SageMaker is preparing the model variant on the hosted
    ///   inference endpoint.
    /// * `InService` - The model variant is running on the hosted inference
    ///   endpoint.
    /// * `Updating` - Amazon SageMaker is updating the model variant on the hosted
    ///   inference endpoint.
    /// * `Deleting` - Amazon SageMaker is deleting the model variant on the hosted
    ///   inference endpoint.
    /// * `Deleted` - The model variant has been deleted on the hosted inference
    ///   endpoint. This can only happen after stopping the experiment.
    status: ModelVariantStatus,

    /// The name of the variant.
    variant_name: []const u8,

    pub const json_field_names = .{
        .infrastructure_config = "InfrastructureConfig",
        .model_name = "ModelName",
        .status = "Status",
        .variant_name = "VariantName",
    };
};
