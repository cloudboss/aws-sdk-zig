const DeliverySourceConfigurationSchemaValueType = @import("delivery_source_configuration_schema_value_type.zig").DeliverySourceConfigurationSchemaValueType;

/// A structure that describes a single configuration for a log type,
/// including its name, value type, default value, and the range of supported
/// values.
pub const DeliverySourceConfigurationSchema = struct {
    /// The default value of the configuration that is used when a value is not
    /// specified in a
    /// [PutDeliverySource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliverySource.html) request.
    default_value: []const u8,

    /// The name of the configuration.
    key_name: []const u8,

    /// The maximum numeric value allowed for the configuration. This applies only
    /// when
    /// the `valueType` is a numeric type.
    max_value: ?f64 = null,

    /// The minimum numeric value allowed for the configuration. This applies only
    /// when
    /// the `valueType` is a numeric type.
    min_value: ?f64 = null,

    /// The list of allowed values for the configuration. Empty for free-form
    /// configuration.
    supported_values: ?[]const []const u8 = null,

    /// The data type of the configuration value. Valid values are `string`,
    /// `boolean`, `int`, `double`, and
    /// `long`.
    value_type: DeliverySourceConfigurationSchemaValueType,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .key_name = "keyName",
        .max_value = "maxValue",
        .min_value = "minValue",
        .supported_values = "supportedValues",
        .value_type = "valueType",
    };
};
