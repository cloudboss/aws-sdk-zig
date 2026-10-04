const InferenceConnectorTargetConfiguration = @import("inference_connector_target_configuration.zig").InferenceConnectorTargetConfiguration;
const InferenceProviderTargetConfiguration = @import("inference_provider_target_configuration.zig").InferenceProviderTargetConfiguration;

/// The configuration for an inference target. An inference target routes
/// requests to a large language model (LLM) provider, either through a built-in
/// connector or an explicitly configured provider.
pub const InferenceTargetConfiguration = union(enum) {
    /// The connector-based inference configuration. Use this option to route
    /// requests to an LLM provider through a built-in connector that includes
    /// predefined provider rules.
    connector: ?InferenceConnectorTargetConfiguration,
    /// The provider-based inference configuration. Use this option to explicitly
    /// configure the endpoint, model mapping, and operations for an LLM provider.
    provider: ?InferenceProviderTargetConfiguration,

    pub const json_field_names = .{
        .connector = "connector",
        .provider = "provider",
    };
};
