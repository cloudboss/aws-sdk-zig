const ConnectorParameterOverride = @import("connector_parameter_override.zig").ConnectorParameterOverride;

/// Configuration for a single tool within a connector.
pub const ConnectorConfiguration = struct {
    /// An agent-facing description override for this tool.
    description: ?[]const u8 = null,

    /// The tool or operation name (for example, `retrieve` or `webSearch`).
    name: []const u8,

    /// Parameters to expose to the agent at runtime, with optional description
    /// overrides.
    parameter_overrides: ?[]const ConnectorParameterOverride = null,

    /// Parameters to set as fixed or default values when provisioning this tool.
    parameter_values: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .parameter_overrides = "parameterOverrides",
        .parameter_values = "parameterValues",
    };
};
