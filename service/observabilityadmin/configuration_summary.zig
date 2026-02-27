const DataSource = @import("data_source.zig").DataSource;
const Source = @import("source.zig").Source;

/// Provides a summary of pipeline configuration components including sources,
/// processors, and destinations.
pub const ConfigurationSummary = struct {
    /// The list of data sources that provide telemetry data to the pipeline.
    data_sources: ?[]const DataSource,

    /// The total number of processors configured in the pipeline.
    processor_count: ?i32,

    /// The list of processors configured in the pipeline for data transformation.
    processors: ?[]const []const u8,

    /// The list of destinations where processed data is sent.
    sinks: ?[]const []const u8,

    /// The list of data sources configured in the pipeline.
    sources: ?[]const Source,

    pub const json_field_names = .{
        .data_sources = "DataSources",
        .processor_count = "ProcessorCount",
        .processors = "Processors",
        .sinks = "Sinks",
        .sources = "Sources",
    };
};
