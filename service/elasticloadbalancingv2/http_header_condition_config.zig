/// Information about an HTTP header condition.
///
/// There is a set of standard HTTP header fields. You can also define custom
/// HTTP header
/// fields.
pub const HttpHeaderConditionConfig = struct {
    /// The name of the HTTP header field. The maximum length is 40 characters. The
    /// header name is
    /// case insensitive. The allowed characters are specified by RFC 7230.
    /// Wildcards are not
    /// supported.
    ///
    /// You can't use an HTTP header condition to specify the host header. Instead,
    /// use a [host
    /// condition](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html#host-conditions).
    http_header_name: ?[]const u8,

    /// The regular expression to compare against the HTTP header. The maximum
    /// length of each string is 128 characters.
    regex_values: ?[]const []const u8,

    /// The strings to compare against the value of the HTTP header. The maximum
    /// length of
    /// each string is 128 characters. The comparison strings are case insensitive.
    /// The following
    /// wildcard characters are supported: * (matches 0 or more characters) and ?
    /// (matches exactly 1
    /// character).
    ///
    /// If the same header appears multiple times in the request, we search them in
    /// order until a
    /// match is found.
    ///
    /// If you specify multiple strings, the condition is satisfied if one of the
    /// strings matches
    /// the value of the HTTP header. To require that all of the strings are a
    /// match, create one
    /// condition per string.
    values: ?[]const []const u8,
};
