const OpenSearchExporterConfiguration = @import("open_search_exporter_configuration.zig").OpenSearchExporterConfiguration;

/// Contains the configuration for an exporter managed by the scraper.
pub const ExporterConfiguration = union(enum) {
    /// The configuration that the scraper uses to export metrics to an Amazon
    /// OpenSearch Service domain.
    open_search_configuration: ?OpenSearchExporterConfiguration,

    pub const json_field_names = .{
        .open_search_configuration = "openSearchConfiguration",
    };
};
