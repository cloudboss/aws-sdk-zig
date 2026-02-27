const Crawl = @import("crawl.zig").Crawl;

/// The details of a Crawler node present in the workflow.
pub const CrawlerNodeDetails = struct {
    /// A list of crawls represented by the crawl node.
    crawls: ?[]const Crawl,

    pub const json_field_names = .{
        .crawls = "Crawls",
    };
};
