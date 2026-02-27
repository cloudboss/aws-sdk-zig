const aws = @import("aws");

/// Values for use in player attribute key-value pairs. This object lets
/// you specify an attribute value using any of the valid data types: string,
/// number, string
/// array, or data map. Each `AttributeValue` object can use only one of the
/// available properties.
pub const AttributeValue = struct {
    /// For number values, expressed as double.
    n: ?f64,

    /// For single string values. Maximum string length is 100 characters.
    s: ?[]const u8,

    /// For a map of up to 10 data type:value pairs. Maximum length for each string
    /// value is
    /// 100 characters.
    sdm: ?[]const aws.map.MapEntry(f64),

    /// For a list of up to 100 strings. Maximum length for each string is 100
    /// characters.
    /// Duplicate values are not recognized; all occurrences of the repeated value
    /// after the
    /// first of a repeated value are ignored.
    sl: ?[]const []const u8,

    pub const json_field_names = .{
        .n = "N",
        .s = "S",
        .sdm = "SDM",
        .sl = "SL",
    };
};
