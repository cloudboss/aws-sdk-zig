const aws = @import("aws");

const PassthroughProtocolType = @import("passthrough_protocol_type.zig").PassthroughProtocolType;
const HttpApiSchemaConfiguration = @import("http_api_schema_configuration.zig").HttpApiSchemaConfiguration;
const StaticQueryParameterConflictResolution = @import("static_query_parameter_conflict_resolution.zig").StaticQueryParameterConflictResolution;
const StickinessConfiguration = @import("stickiness_configuration.zig").StickinessConfiguration;

/// The configuration for an HTTP passthrough target. A passthrough target
/// forwards requests directly to an external HTTP endpoint.
pub const PassthroughTargetConfiguration = struct {
    /// The HTTPS endpoint that the gateway forwards requests to for this
    /// passthrough target.
    endpoint: []const u8,

    /// The application protocol that the passthrough target implements. This value
    /// is required for passthrough targets:
    ///
    /// * `MCP` - The Model Context Protocol.
    /// * `A2A` - The Agent-to-Agent protocol.
    /// * `INFERENCE` - The protocol for routing requests to a large language model
    ///   (LLM) provider.
    /// * `CUSTOM` - A custom application protocol.
    protocol_type: PassthroughProtocolType,

    /// The API schema configuration that defines the structure of the passthrough
    /// target's API.
    schema: ?HttpApiSchemaConfiguration = null,

    /// Controls precedence when a client request supplies a query parameter whose
    /// name matches a configured static query parameter. If not set, defaults to
    /// `CLIENT_OVERRIDE`:
    ///
    /// * `CLIENT_OVERRIDE` - The client-supplied value overrides the configured
    ///   static value for that parameter name.
    /// * `STATIC_OVERRIDE` - The configured static value is retained, overriding
    ///   the client-supplied value for that parameter name.
    static_query_parameter_conflict_resolution: ?StaticQueryParameterConflictResolution = null,

    /// A map of static query parameters that the gateway always appends to the
    /// outbound URL when forwarding requests to the target. The total outbound URL
    /// length, which includes the endpoint and the percent-encoded query
    /// parameters, is enforced by the service.
    static_query_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The session stickiness configuration for the passthrough target. This
    /// configuration routes requests within the same session to the same target.
    stickiness_configuration: ?StickinessConfiguration = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
        .protocol_type = "protocolType",
        .schema = "schema",
        .static_query_parameter_conflict_resolution = "staticQueryParameterConflictResolution",
        .static_query_parameters = "staticQueryParameters",
        .stickiness_configuration = "stickinessConfiguration",
    };
};
