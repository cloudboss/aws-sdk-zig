/// Specifies configuration information for the input data for the inference,
/// including
/// timestamp format and delimiter.
pub const InferenceInputNameConfiguration = struct {
    /// Indicates the delimiter character used between items in the data.
    component_timestamp_delimiter: ?[]const u8 = null,

    /// The format of the timestamp, whether Epoch time, or standard, with or
    /// without hyphens
    /// (-).
    timestamp_format: ?[]const u8 = null,

    pub const json_field_names = .{
        .component_timestamp_delimiter = "ComponentTimestampDelimiter",
        .timestamp_format = "TimestampFormat",
    };
};
