const QueryStringKeyValuePair = @import("query_string_key_value_pair.zig").QueryStringKeyValuePair;

/// The conditions for a routing rule. All specified fields must match for the
/// rule to apply (AND logic). At least one condition field must be set.
pub const RuleCondition = struct {
    /// The exact host header value to match.
    host_header: ?[]const u8 = null,

    /// A wildcard pattern for host header matching (for example, `*.example.com`).
    host_header_wildcard: ?[]const u8 = null,

    /// The exact path to match. Must start with `/`.
    path_exact: ?[]const u8 = null,

    /// The path prefix to match. The request path must start with this value. Must
    /// start with `/`.
    path_prefix: ?[]const u8 = null,

    /// A query string key-value pair that must be present and match exactly.
    query_string_equals: ?QueryStringKeyValuePair = null,

    /// A query string key that must be present in the request (any value is
    /// accepted).
    query_string_exists: ?[]const u8 = null,

    pub const json_field_names = .{
        .host_header = "hostHeader",
        .host_header_wildcard = "hostHeaderWildcard",
        .path_exact = "pathExact",
        .path_prefix = "pathPrefix",
        .query_string_equals = "queryStringEquals",
        .query_string_exists = "queryStringExists",
    };
};
