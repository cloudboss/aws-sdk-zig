const RuntimeTargetConfiguration = @import("runtime_target_configuration.zig").RuntimeTargetConfiguration;
const HttpConnectorTargetConfiguration = @import("http_connector_target_configuration.zig").HttpConnectorTargetConfiguration;
const PassthroughTargetConfiguration = @import("passthrough_target_configuration.zig").PassthroughTargetConfiguration;

/// The HTTP target configuration for a gateway target. Contains the
/// configuration for HTTP-based target endpoints.
pub const HttpTargetConfiguration = union(enum) {
    /// The AgentCore Runtime target configuration for HTTP-based communication with
    /// an agent runtime.
    agentcore_runtime: ?RuntimeTargetConfiguration,
    /// The connector-based configuration for the HTTP target. Use this
    /// configuration when you want to route HTTP requests through a managed
    /// connector.
    connector: ?HttpConnectorTargetConfiguration,
    /// The passthrough configuration for the HTTP target. A passthrough target
    /// forwards requests directly to an external HTTP endpoint.
    passthrough: ?PassthroughTargetConfiguration,

    pub const json_field_names = .{
        .agentcore_runtime = "agentcoreRuntime",
        .connector = "connector",
        .passthrough = "passthrough",
    };
};
