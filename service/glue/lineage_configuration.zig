const CrawlerLineageSettings = @import("crawler_lineage_settings.zig").CrawlerLineageSettings;

/// Specifies data lineage configuration settings for the crawler.
pub const LineageConfiguration = struct {
    /// Specifies whether data lineage is enabled for the crawler. Valid values are:
    ///
    /// * ENABLE: enables data lineage for the crawler
    ///
    /// * DISABLE: disables data lineage for the crawler
    crawler_lineage_settings: ?CrawlerLineageSettings = null,

    pub const json_field_names = .{
        .crawler_lineage_settings = "CrawlerLineageSettings",
    };
};
