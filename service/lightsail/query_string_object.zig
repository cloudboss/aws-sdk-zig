/// Describes the query string parameters that an Amazon Lightsail content
/// delivery network
/// (CDN) distribution to bases caching on.
///
/// For the query strings that you specify, your distribution caches separate
/// versions of the
/// specified content based on the query string values in viewer
/// requests.
pub const QueryStringObject = struct {
    /// Indicates whether the distribution forwards and caches based on query
    /// strings.
    option: ?bool = null,

    /// The specific query strings that the distribution forwards to the origin.
    ///
    /// Your distribution will cache content based on the specified query strings.
    ///
    /// If the `option` parameter is true, then your distribution forwards all query
    /// strings, regardless of what you specify using the `queryStringsAllowList`
    /// parameter.
    query_strings_allow_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .option = "option",
        .query_strings_allow_list = "queryStringsAllowList",
    };
};
