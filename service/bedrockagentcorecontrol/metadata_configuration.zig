/// Configuration for HTTP header and query parameter propagation between the
/// gateway and target servers.
pub const MetadataConfiguration = struct {
    /// A list of URL query parameters that are allowed to be propagated from
    /// incoming gateway URL to the target.
    allowed_query_parameters: ?[]const []const u8,

    /// A list of HTTP headers that are allowed to be propagated from incoming
    /// client requests to the target.
    allowed_request_headers: ?[]const []const u8,

    /// A list of HTTP headers that are allowed to be propagated from the target
    /// response back to the client.
    allowed_response_headers: ?[]const []const u8,

    pub const json_field_names = .{
        .allowed_query_parameters = "allowedQueryParameters",
        .allowed_request_headers = "allowedRequestHeaders",
        .allowed_response_headers = "allowedResponseHeaders",
    };
};
