const AssetPropertyTimestamp = @import("asset_property_timestamp.zig").AssetPropertyTimestamp;
const AssetPropertyVariant = @import("asset_property_variant.zig").AssetPropertyVariant;

/// A structure that contains value information. For more information, see
/// [AssetPropertyValue](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_AssetPropertyValue.html) in the *AWS IoT SiteWise API Reference*.
///
/// You must use expressions for all parameters in `AssetPropertyValue`. The
/// expressions accept literals, operators, functions, references, and
/// substitution
/// templates.
///
/// **Examples**
///
/// * For literal values, the expressions must contain single quotes. For
///   example, the value
/// for the `quality` parameter can be `'GOOD'`.
///
/// * For references, you must specify either variables or input values. For
///   example, the
/// value for the `quality` parameter can be
/// `$input.TemperatureInput.sensorData.quality`.
///
/// For more information,
/// see
/// [Expressions](https://docs.aws.amazon.com/iotevents/latest/developerguide/iotevents-expressions.html)
/// in the *AWS IoT Events Developer Guide*.
pub const AssetPropertyValue = struct {
    /// The quality of the asset property value. The value must be `'GOOD'`,
    /// `'BAD'`, or `'UNCERTAIN'`.
    quality: ?[]const u8 = null,

    /// The timestamp associated with the asset property value. The default is the
    /// current event
    /// time.
    timestamp: ?AssetPropertyTimestamp = null,

    /// The value to send to an asset property.
    value: ?AssetPropertyVariant = null,

    pub const json_field_names = .{
        .quality = "quality",
        .timestamp = "timestamp",
        .value = "value",
    };
};
