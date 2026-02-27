const RecrawlBehavior = @import("recrawl_behavior.zig").RecrawlBehavior;

/// When crawling an Amazon S3 data source after the first crawl is complete,
/// specifies whether to crawl the entire dataset again or to crawl only folders
/// that were added since the last crawler run. For more information, see
/// [Incremental Crawls in
/// Glue](https://docs.aws.amazon.com/glue/latest/dg/incremental-crawls.html) in
/// the developer guide.
pub const RecrawlPolicy = struct {
    /// Specifies whether to crawl the entire dataset again or to crawl only folders
    /// that were added since the last crawler run.
    ///
    /// A value of `CRAWL_EVERYTHING` specifies crawling the entire dataset again.
    ///
    /// A value of `CRAWL_NEW_FOLDERS_ONLY` specifies crawling only folders that
    /// were added since the last crawler run.
    ///
    /// A value of `CRAWL_EVENT_MODE` specifies crawling only the changes identified
    /// by Amazon S3 events.
    recrawl_behavior: ?RecrawlBehavior,

    pub const json_field_names = .{
        .recrawl_behavior = "RecrawlBehavior",
    };
};
