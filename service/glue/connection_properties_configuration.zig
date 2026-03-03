const ConnectorProperty = @import("connector_property.zig").ConnectorProperty;

/// Configuration that defines the base URL and additional request parameters
/// needed during connection creation.
pub const ConnectionPropertiesConfiguration = struct {
    /// Key-value pairs of additional request parameters that may be needed during
    /// connection creation, such as API versions or service-specific configuration
    /// options.
    additional_request_parameters: ?[]const ConnectorProperty = null,

    /// The base instance URL for the endpoint that this connection type will
    /// connect to.
    url: ?ConnectorProperty = null,

    pub const json_field_names = .{
        .additional_request_parameters = "AdditionalRequestParameters",
        .url = "Url",
    };
};
