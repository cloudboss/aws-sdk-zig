/// A structure that contains an asset property value. For more information, see
/// [Variant](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_Variant.html)
/// in the *AWS IoT SiteWise API Reference*.
///
/// You must use expressions for all parameters in `AssetPropertyVariant`. The
/// expressions accept literals, operators, functions, references, and
/// substitution
/// templates.
///
/// **Examples**
///
/// * For literal values, the expressions must contain single quotes. For
///   example, the value
/// for the `integerValue` parameter can be `'100'`.
///
/// * For references, you must specify either variables or parameters. For
///   example, the
/// value for the `booleanValue` parameter can be
/// `$variable.offline`.
///
/// * For a substitution template, you must use `${}`, and the template must be
/// in single quotes. A substitution template can also contain a combination of
/// literals,
/// operators, functions, references, and substitution templates.
///
/// In the following example, the value for the `doubleValue` parameter uses a
/// substitution template.
///
/// `'${$input.TemperatureInput.sensorData.temperature * 6 / 5 + 32}'`
///
/// For more information,
/// see
/// [Expressions](https://docs.aws.amazon.com/iotevents/latest/developerguide/iotevents-expressions.html)
/// in the *AWS IoT Events Developer Guide*.
///
/// You must specify one of the following value types, depending on the
/// `dataType`
/// of the specified asset property. For more information, see
/// [AssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_AssetProperty.html) in the
/// *AWS IoT SiteWise API Reference*.
pub const AssetPropertyVariant = struct {
    /// The asset property value is a Boolean value that must be `'TRUE'` or
    /// `'FALSE'`. You must use an expression, and the evaluated result should be a
    /// Boolean value.
    boolean_value: ?[]const u8,

    /// The asset property value is a double. You must use an expression, and the
    /// evaluated result
    /// should be a double.
    double_value: ?[]const u8,

    /// The asset property value is an integer. You must use an expression, and the
    /// evaluated
    /// result should be an integer.
    integer_value: ?[]const u8,

    /// The asset property value is a string. You must use an expression, and the
    /// evaluated result
    /// should be a string.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .integer_value = "integerValue",
        .string_value = "stringValue",
    };
};
