const MessageData = @import("message_data.zig").MessageData;
const StatusCode = @import("status_code.zig").StatusCode;

/// A `GetMetricData` call returns an array of `MetricDataResult`
/// structures. Each of these structures includes the data points for that
/// metric, along
/// with the timestamps of those data points and other identifying information.
pub const MetricDataResult = struct {
    /// The short name you specified to represent this metric.
    id: ?[]const u8 = null,

    /// The human-readable label associated with the data.
    label: ?[]const u8 = null,

    /// A list of messages with additional information about the data returned.
    messages: ?[]const MessageData = null,

    /// The status of the returned data. `Complete` indicates that all data points
    /// in the requested time range were returned. `PartialData` means that an
    /// incomplete set of data points were returned. You can use the `NextToken`
    /// value that was returned and repeat your request to get more data points.
    /// `NextToken` is not returned if you are performing a math expression.
    /// `InternalError` indicates that an error occurred. Retry your request
    /// using `NextToken`, if present.
    status_code: ?StatusCode = null,

    /// The timestamps for the data points, formatted in Unix timestamp format. The
    /// number of
    /// timestamps always matches the number of values and the value for
    /// Timestamps[x] is
    /// Values[x].
    timestamps: ?[]const i64 = null,

    /// The data points for the metric corresponding to `Timestamps`. The number of
    /// values always matches the number of timestamps and the timestamp for
    /// Values[x] is
    /// Timestamps[x].
    values: ?[]const f64 = null,

    pub const json_field_names = .{
        .id = "Id",
        .label = "Label",
        .messages = "Messages",
        .status_code = "StatusCode",
        .timestamps = "Timestamps",
        .values = "Values",
    };
};
