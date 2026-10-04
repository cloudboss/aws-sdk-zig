const InferenceConnectorSource = @import("inference_connector_source.zig").InferenceConnectorSource;

/// The configuration for a connector-based inference target. This configuration
/// uses a built-in connector that provides predefined rules for a large
/// language model (LLM) provider.
pub const InferenceConnectorTargetConfiguration = struct {
    /// The source configuration identifying which inference connector to use.
    source: InferenceConnectorSource,

    pub const json_field_names = .{
        .source = "source",
    };
};
