/// A data type that contains a `Timestamp` object. This is specified
/// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
/// 1
/// millisecond past June 1, 2020 1:15:02 PM UTC.
pub const TimestampStructure = struct {
    /// A `Timestamp`. This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    value: i64,

    pub const json_field_names = .{
        .value = "value",
    };
};
