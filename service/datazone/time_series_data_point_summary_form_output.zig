/// The summary of the time series data points form.
pub const TimeSeriesDataPointSummaryFormOutput = struct {
    /// The content of the summary of the time series data points form.
    content_summary: ?[]const u8,

    /// The name of the time series data points summary form.
    form_name: []const u8,

    /// The ID of the time series data points summary form.
    id: ?[]const u8,

    /// The timestamp of the time series data points summary form.
    timestamp: i64,

    /// The type ID of the time series data points summary form.
    type_identifier: []const u8,

    /// The type revision of the time series data points summary form.
    type_revision: ?[]const u8,

    pub const json_field_names = .{
        .content_summary = "contentSummary",
        .form_name = "formName",
        .id = "id",
        .timestamp = "timestamp",
        .type_identifier = "typeIdentifier",
        .type_revision = "typeRevision",
    };
};
