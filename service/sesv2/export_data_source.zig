const MessageInsightsDataSource = @import("message_insights_data_source.zig").MessageInsightsDataSource;
const MetricsDataSource = @import("metrics_data_source.zig").MetricsDataSource;

/// An object that contains details about the data source of the export job. It
/// can only
/// contain one of `MetricsDataSource` or `MessageInsightsDataSource` object.
pub const ExportDataSource = struct {
    message_insights_data_source: ?MessageInsightsDataSource = null,

    metrics_data_source: ?MetricsDataSource = null,

    pub const json_field_names = .{
        .message_insights_data_source = "MessageInsightsDataSource",
        .metrics_data_source = "MetricsDataSource",
    };
};
