const PatternObjectFilterConfiguration = @import("pattern_object_filter_configuration.zig").PatternObjectFilterConfiguration;
const CrawlFilterConfigurationType = @import("crawl_filter_configuration_type.zig").CrawlFilterConfigurationType;

/// The configuration of filtering the data source content. For example,
/// configuring regular expression patterns to include or exclude certain
/// content.
pub const CrawlFilterConfiguration = struct {
    /// The configuration of filtering certain objects or content types of the data
    /// source.
    pattern_object_filter: ?PatternObjectFilterConfiguration,

    /// The type of filtering that you want to apply to certain objects or content
    /// of the data source. For example, the `PATTERN` type is regular expression
    /// patterns you can apply to filter your content.
    @"type": CrawlFilterConfigurationType,

    pub const json_field_names = .{
        .pattern_object_filter = "patternObjectFilter",
        .@"type" = "type",
    };
};
