const QueryStringKeyValuePair = @import("query_string_key_value_pair.zig").QueryStringKeyValuePair;

/// Information about a query string condition.
///
/// The query string component of a URI starts after the first '?' character and
/// is terminated
/// by either a '#' character or the end of the URI. A typical query string
/// contains key/value
/// pairs separated by '&' characters. The allowed characters are specified by
/// RFC 3986. Any
/// character can be percentage encoded.
pub const QueryStringConditionConfig = struct {
    /// The key/value pairs or values to find in the query string. The maximum
    /// length of
    /// each string is 128 characters. The comparison is case insensitive. The
    /// following wildcard
    /// characters are supported: * (matches 0 or more characters) and ? (matches
    /// exactly 1
    /// character). To search for a literal '*' or '?' character in a query string,
    /// you must escape
    /// these characters in `Values` using a '\' character.
    ///
    /// If you specify multiple key/value pairs or values, the condition is
    /// satisfied if one of
    /// them is found in the query string.
    values: ?[]const QueryStringKeyValuePair,
};
