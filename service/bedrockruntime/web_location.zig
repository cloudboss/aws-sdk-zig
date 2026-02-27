/// Provides the URL and domain information for the website that was cited when
/// performing a web search.
pub const WebLocation = struct {
    /// The domain that was cited when performing a web search.
    domain: ?[]const u8,

    /// The URL that was cited when performing a web search.
    url: ?[]const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .url = "url",
    };
};
