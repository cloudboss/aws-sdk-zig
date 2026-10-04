const aws = @import("aws");

const HttpConnectorSource = @import("http_connector_source.zig").HttpConnectorSource;

/// The configuration for an HTTP connector target. Use this configuration when
/// you want to route HTTP requests through a managed connector.
pub const HttpConnectorTargetConfiguration = struct {
    /// The resource parameters for this connector (for example, `memoryId`). The
    /// service validates these parameters against the request path at runtime.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The source configuration identifying which HTTP connector to use.
    source: HttpConnectorSource,

    pub const json_field_names = .{
        .parameters = "parameters",
        .source = "source",
    };
};
