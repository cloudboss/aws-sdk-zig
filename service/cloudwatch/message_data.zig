/// A message returned by the `GetMetricData`API, including a code and a
/// description.
///
/// If a cross-Region `GetMetricData` operation fails with a code of
/// `Forbidden` and a value of `Authentication too complex to retrieve
/// cross region data`, you can correct the problem by running the
/// `GetMetricData` operation in the same Region where the metric data
/// is.
pub const MessageData = struct {
    /// The error code or status code associated with the message.
    code: ?[]const u8,

    /// The message text.
    value: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .value = "Value",
    };
};
