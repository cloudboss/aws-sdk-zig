/// Information about a path pattern condition.
pub const PathPatternConditionConfig = struct {
    /// The regular expressions to compare against the request URL. The maximum
    /// length of each string is 128 characters.
    regex_values: ?[]const []const u8 = null,

    /// The path patterns to compare against the request URL. The maximum length of
    /// each
    /// string is 128 characters. The comparison is case sensitive. The following
    /// wildcard characters
    /// are supported: * (matches 0 or more characters) and ? (matches exactly 1
    /// character).
    ///
    /// If you specify multiple strings, the condition is satisfied if one of them
    /// matches the
    /// request URL. The path pattern is compared only to the path of the URL, not
    /// to its query
    /// string. To compare against the query string, use a [query string
    /// condition](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html#query-string-conditions).
    values: ?[]const []const u8 = null,
};
