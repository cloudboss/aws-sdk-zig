/// The time series data points form.
pub const TimeSeriesDataPointFormInput = struct {
    /// The content of the time series data points form.
    content: ?[]const u8 = null,

    /// The name of the time series data points form.
    form_name: []const u8,

    /// The timestamp of the time series data points form.
    timestamp: i64,

    /// The ID of the type of the time series data points form.
    type_identifier: []const u8,

    /// The revision type of the time series data points form.
    type_revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "content",
        .form_name = "formName",
        .timestamp = "timestamp",
        .type_identifier = "typeIdentifier",
        .type_revision = "typeRevision",
    };
};
