/// A URL for crawling.
pub const SeedUrl = struct {
    /// URL for crawling
    url: ?[]const u8,

    pub const json_field_names = .{
        .url = "url",
    };
};
