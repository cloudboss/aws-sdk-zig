const PaginationConfiguration = @import("pagination_configuration.zig").PaginationConfiguration;
const HTTPMethod = @import("http_method.zig").HTTPMethod;
const ConnectorProperty = @import("connector_property.zig").ConnectorProperty;
const ResponseConfiguration = @import("response_configuration.zig").ResponseConfiguration;

/// Configuration that defines how to make requests to endpoints, including
/// request methods, paths, parameters, and response handling.
pub const SourceConfiguration = struct {
    /// Configuration for handling paginated responses from the REST API, supporting
    /// both cursor-based and offset-based pagination strategies.
    pagination_configuration: ?PaginationConfiguration = null,

    /// The HTTP method to use for requests to this endpoint, such as GET, POST.
    request_method: ?HTTPMethod = null,

    /// Configuration for request parameters that should be included in API calls,
    /// such as query parameters, headers, or body content.
    request_parameters: ?[]const ConnectorProperty = null,

    /// The URL path for the REST endpoint, which may include parameter placeholders
    /// that will be replaced with actual values during requests.
    request_path: ?[]const u8 = null,

    /// Configuration that defines how to parse and extract data from API responses,
    /// including success and error handling.
    response_configuration: ?ResponseConfiguration = null,

    pub const json_field_names = .{
        .pagination_configuration = "PaginationConfiguration",
        .request_method = "RequestMethod",
        .request_parameters = "RequestParameters",
        .request_path = "RequestPath",
        .response_configuration = "ResponseConfiguration",
    };
};
