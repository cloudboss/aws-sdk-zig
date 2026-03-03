/// Information about an HTTP method condition.
///
/// HTTP defines a set of request methods, also referred to as HTTP verbs. For
/// more
/// information, see the [HTTP Method
/// Registry](https://www.iana.org/assignments/http-methods/http-methods.xhtml).
/// You can also define custom HTTP methods.
pub const HttpRequestMethodConditionConfig = struct {
    /// The name of the request method. The maximum length is 40 characters. The
    /// allowed characters
    /// are A-Z, hyphen (-), and underscore (_). The comparison is case sensitive.
    /// Wildcards are not
    /// supported; therefore, the method name must be an exact match.
    ///
    /// If you specify multiple strings, the condition is satisfied if one of the
    /// strings matches
    /// the HTTP request method. We recommend that you route GET and HEAD requests
    /// in the same way,
    /// because the response to a HEAD request may be cached.
    values: ?[]const []const u8 = null,
};
