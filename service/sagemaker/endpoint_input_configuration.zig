const EnvironmentParameterRanges = @import("environment_parameter_ranges.zig").EnvironmentParameterRanges;
const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;
const ProductionVariantServerlessConfig = @import("production_variant_serverless_config.zig").ProductionVariantServerlessConfig;

/// The endpoint configuration for the load test.
pub const EndpointInputConfiguration = struct {
    /// The parameter you want to benchmark against.
    environment_parameter_ranges: ?EnvironmentParameterRanges = null,

    /// The inference specification name in the model package version.
    inference_specification_name: ?[]const u8 = null,

    /// The instance types to use for the load test.
    instance_type: ?ProductionVariantInstanceType = null,

    serverless_config: ?ProductionVariantServerlessConfig = null,

    pub const json_field_names = .{
        .environment_parameter_ranges = "EnvironmentParameterRanges",
        .inference_specification_name = "InferenceSpecificationName",
        .instance_type = "InstanceType",
        .serverless_config = "ServerlessConfig",
    };
};
