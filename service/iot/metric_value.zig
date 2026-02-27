/// The value to be compared with the `metric`.
pub const MetricValue = struct {
    /// If the `comparisonOperator` calls for a set of CIDRs, use this
    /// to specify that set to be compared with the `metric`.
    cidrs: ?[]const []const u8,

    /// If the `comparisonOperator` calls for a numeric value, use this
    /// to specify that numeric value to be compared with the `metric`.
    count: ?i64,

    /// The numeral value of a metric.
    number: ?f64,

    /// The numeral values of a metric.
    numbers: ?[]const f64,

    /// If the `comparisonOperator` calls for a set of ports, use this
    /// to specify that set to be compared with the `metric`.
    ports: ?[]const i32,

    /// The string values of a metric.
    strings: ?[]const []const u8,

    pub const json_field_names = .{
        .cidrs = "cidrs",
        .count = "count",
        .number = "number",
        .numbers = "numbers",
        .ports = "ports",
        .strings = "strings",
    };
};
