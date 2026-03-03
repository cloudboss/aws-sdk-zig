const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;
const ProductionVariantServerlessConfig = @import("production_variant_serverless_config.zig").ProductionVariantServerlessConfig;

/// The endpoint configuration made by Inference Recommender during a
/// recommendation job.
pub const EndpointOutputConfiguration = struct {
    /// The name of the endpoint made during a recommendation job.
    endpoint_name: []const u8,

    /// The number of instances recommended to launch initially.
    initial_instance_count: ?i32 = null,

    /// The instance type recommended by Amazon SageMaker Inference Recommender.
    instance_type: ?ProductionVariantInstanceType = null,

    serverless_config: ?ProductionVariantServerlessConfig = null,

    /// The name of the production variant (deployed model) made during a
    /// recommendation job.
    variant_name: []const u8,

    pub const json_field_names = .{
        .endpoint_name = "EndpointName",
        .initial_instance_count = "InitialInstanceCount",
        .instance_type = "InstanceType",
        .serverless_config = "ServerlessConfig",
        .variant_name = "VariantName",
    };
};
