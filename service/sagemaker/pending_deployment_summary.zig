const PendingProductionVariantSummary = @import("pending_production_variant_summary.zig").PendingProductionVariantSummary;

/// The summary of an in-progress deployment when an endpoint is creating or
/// updating with a new endpoint configuration.
pub const PendingDeploymentSummary = struct {
    /// The name of the endpoint configuration used in the deployment.
    endpoint_config_name: []const u8,

    /// An array of
    /// [PendingProductionVariantSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_PendingProductionVariantSummary.html) objects, one for each model hosted behind this endpoint for the in-progress deployment.
    production_variants: ?[]const PendingProductionVariantSummary = null,

    /// An array of
    /// [PendingProductionVariantSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_PendingProductionVariantSummary.html) objects, one for each model hosted behind this endpoint in shadow mode with production traffic replicated from the model specified on `ProductionVariants` for the in-progress deployment.
    shadow_production_variants: ?[]const PendingProductionVariantSummary = null,

    /// The start time of the deployment.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .endpoint_config_name = "EndpointConfigName",
        .production_variants = "ProductionVariants",
        .shadow_production_variants = "ShadowProductionVariants",
        .start_time = "StartTime",
    };
};
