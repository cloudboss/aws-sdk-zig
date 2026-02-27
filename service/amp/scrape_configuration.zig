/// A scrape configuration for a scraper, base 64 encoded. For more information,
/// see [Scraper
/// configuration](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-collector-how-to.html#AMP-collector-configuration) in the *Amazon Managed Service for Prometheus User Guide*.
pub const ScrapeConfiguration = union(enum) {
    /// The base 64 encoded scrape configuration file.
    configuration_blob: ?[]const u8,

    pub const json_field_names = .{
        .configuration_blob = "configurationBlob",
    };
};
