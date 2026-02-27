const ConnectionBodyParameter = @import("connection_body_parameter.zig").ConnectionBodyParameter;
const ConnectionHeaderParameter = @import("connection_header_parameter.zig").ConnectionHeaderParameter;
const ConnectionQueryStringParameter = @import("connection_query_string_parameter.zig").ConnectionQueryStringParameter;

/// Any additional parameters for the connection.
pub const ConnectionHttpParameters = struct {
    /// Any additional body string parameters for the connection.
    body_parameters: ?[]const ConnectionBodyParameter,

    /// Any additional header parameters for the connection.
    header_parameters: ?[]const ConnectionHeaderParameter,

    /// Any additional query string parameters for the connection.
    query_string_parameters: ?[]const ConnectionQueryStringParameter,

    pub const json_field_names = .{
        .body_parameters = "BodyParameters",
        .header_parameters = "HeaderParameters",
        .query_string_parameters = "QueryStringParameters",
    };
};
