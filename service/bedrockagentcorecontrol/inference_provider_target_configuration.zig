const ModelMapping = @import("model_mapping.zig").ModelMapping;
const InferenceOperationConfiguration = @import("inference_operation_configuration.zig").InferenceOperationConfiguration;

/// The configuration for a provider-based inference target. This configuration
/// explicitly defines the endpoint, model mapping, and operations used to route
/// requests to a large language model (LLM) provider.
pub const InferenceProviderTargetConfiguration = struct {
    /// The HTTPS endpoint of the inference provider that the gateway forwards
    /// requests to.
    endpoint: []const u8,

    /// The configuration that translates client-facing model IDs to the model IDs
    /// expected by the provider.
    model_mapping: ?ModelMapping = null,

    /// A list of per-operation configurations that map request paths to the models
    /// supported for each operation.
    operations: ?[]const InferenceOperationConfiguration = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
        .model_mapping = "modelMapping",
        .operations = "operations",
    };
};
