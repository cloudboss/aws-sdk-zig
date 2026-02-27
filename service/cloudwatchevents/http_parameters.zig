const aws = @import("aws");

/// These are custom parameter to be used when the target is an API Gateway REST
/// APIs or
/// EventBridge ApiDestinations. In the latter case, these are merged with any
/// InvocationParameters specified on the Connection, with any values from the
/// Connection taking
/// precedence.
pub const HttpParameters = struct {
    /// The headers that need to be sent as part of request invoking the API Gateway
    /// REST API or
    /// EventBridge ApiDestination.
    header_parameters: ?[]const aws.map.StringMapEntry,

    /// The path parameter values to be used to populate API Gateway REST API or
    /// EventBridge
    /// ApiDestination path wildcards ("*").
    path_parameter_values: ?[]const []const u8,

    /// The query string keys/values that need to be sent as part of request
    /// invoking the API Gateway
    /// REST API or EventBridge ApiDestination.
    query_string_parameters: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .header_parameters = "HeaderParameters",
        .path_parameter_values = "PathParameterValues",
        .query_string_parameters = "QueryStringParameters",
    };
};
