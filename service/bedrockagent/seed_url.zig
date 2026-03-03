/// The seed or starting point URL. You should be authorized to crawl the URL.
pub const SeedUrl = struct {
    /// A seed or starting point URL.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "url",
    };
};
