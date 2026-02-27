/// A structure that contains timestamp information. For more information, see
/// [TimeInNanos](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_TimeInNanos.html) in the *AWS IoT SiteWise API Reference*.
///
/// You must use expressions for all parameters in `AssetPropertyTimestamp`. The
/// expressions accept literals, operators, functions, references, and
/// substitution
/// templates.
///
/// **Examples**
///
/// * For literal values, the expressions must contain single quotes. For
///   example, the value
/// for the `timeInSeconds` parameter can be `'1586400675'`.
///
/// * For references, you must specify either variables or input values. For
///   example, the
/// value for the `offsetInNanos` parameter can be
/// `$variable.time`.
///
/// * For a substitution template, you must use `${}`, and the template must be
/// in single quotes. A substitution template can also contain a combination of
/// literals,
/// operators, functions, references, and substitution templates.
///
/// In the following example, the value for the `timeInSeconds` parameter uses
/// a substitution template.
///
/// `'${$input.TemperatureInput.sensorData.timestamp / 1000}'`
///
/// For more information,
/// see
/// [Expressions](https://docs.aws.amazon.com/iotevents/latest/developerguide/iotevents-expressions.html)
/// in the *AWS IoT Events Developer Guide*.
pub const AssetPropertyTimestamp = struct {
    /// The nanosecond offset converted from `timeInSeconds`. The valid range is
    /// between 0-999999999.
    offset_in_nanos: ?[]const u8,

    /// The timestamp, in seconds, in the Unix epoch format. The valid range is
    /// between
    /// 1-31556889864403199.
    time_in_seconds: []const u8,

    pub const json_field_names = .{
        .offset_in_nanos = "offsetInNanos",
        .time_in_seconds = "timeInSeconds",
    };
};
