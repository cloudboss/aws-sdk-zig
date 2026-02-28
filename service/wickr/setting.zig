/// Represents a single network-level configuration setting with its name,
/// value, and data type. Settings control network-wide behaviors and features.
pub const Setting = struct {
    /// The name of the network setting (e.g., 'enableClientMetrics',
    /// 'dataRetention').
    option_name: []const u8,

    /// The data type of the setting value (e.g., 'boolean', 'string', 'number').
    @"type": []const u8,

    /// The current value of the setting as a string. Boolean values are represented
    /// as 'true' or 'false'.
    value: []const u8,

    pub const json_field_names = .{
        .option_name = "optionName",
        .@"type" = "type",
        .value = "value",
    };
};
