/// The type of data source of an export, can be one of the following:
///
/// * `METRICS_DATA` - The metrics export.
///
/// * `MESSAGE_INSIGHTS` - The Message Insights export.
pub const ExportSourceType = enum {
    metrics_data,
    message_insights,

    pub const json_field_names = .{
        .metrics_data = "METRICS_DATA",
        .message_insights = "MESSAGE_INSIGHTS",
    };
};
