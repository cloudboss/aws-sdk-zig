const SingleHeader = @import("single_header.zig").SingleHeader;

/// Specifies a field in the request to redact from WAF logs, such as headers,
/// query parameters, or body content.
pub const FieldToMatch = struct {
    /// Redacts the HTTP method from WAF logs.
    method: ?[]const u8,

    /// Redacts the entire query string from WAF logs.
    query_string: ?[]const u8,

    /// Redacts a specific header field by name from WAF logs.
    single_header: ?SingleHeader,

    /// Redacts the URI path from WAF logs.
    uri_path: ?[]const u8,

    pub const json_field_names = .{
        .method = "Method",
        .query_string = "QueryString",
        .single_header = "SingleHeader",
        .uri_path = "UriPath",
    };
};
