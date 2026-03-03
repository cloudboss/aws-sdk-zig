const aws = @import("aws");

/// Specifies the HTTP context to use for the test authorizer request.
pub const HttpContext = struct {
    /// The header keys and values in an HTTP authorization request.
    headers: ?[]const aws.map.StringMapEntry = null,

    /// The query string keys and values in an HTTP authorization request.
    query_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .headers = "headers",
        .query_string = "queryString",
    };
};
