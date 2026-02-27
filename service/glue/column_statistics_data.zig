const BinaryColumnStatisticsData = @import("binary_column_statistics_data.zig").BinaryColumnStatisticsData;
const BooleanColumnStatisticsData = @import("boolean_column_statistics_data.zig").BooleanColumnStatisticsData;
const DateColumnStatisticsData = @import("date_column_statistics_data.zig").DateColumnStatisticsData;
const DecimalColumnStatisticsData = @import("decimal_column_statistics_data.zig").DecimalColumnStatisticsData;
const DoubleColumnStatisticsData = @import("double_column_statistics_data.zig").DoubleColumnStatisticsData;
const LongColumnStatisticsData = @import("long_column_statistics_data.zig").LongColumnStatisticsData;
const StringColumnStatisticsData = @import("string_column_statistics_data.zig").StringColumnStatisticsData;
const ColumnStatisticsType = @import("column_statistics_type.zig").ColumnStatisticsType;

/// Contains the individual types of column statistics data. Only one data
/// object should be set and indicated by the `Type` attribute.
pub const ColumnStatisticsData = struct {
    /// Binary column statistics data.
    binary_column_statistics_data: ?BinaryColumnStatisticsData,

    /// Boolean column statistics data.
    boolean_column_statistics_data: ?BooleanColumnStatisticsData,

    /// Date column statistics data.
    date_column_statistics_data: ?DateColumnStatisticsData,

    /// Decimal column statistics data. UnscaledValues within are Base64-encoded
    /// binary objects storing big-endian, two's complement representations of
    /// the decimal's unscaled value.
    decimal_column_statistics_data: ?DecimalColumnStatisticsData,

    /// Double column statistics data.
    double_column_statistics_data: ?DoubleColumnStatisticsData,

    /// Long column statistics data.
    long_column_statistics_data: ?LongColumnStatisticsData,

    /// String column statistics data.
    string_column_statistics_data: ?StringColumnStatisticsData,

    /// The type of column statistics data.
    type: ColumnStatisticsType,

    pub const json_field_names = .{
        .binary_column_statistics_data = "BinaryColumnStatisticsData",
        .boolean_column_statistics_data = "BooleanColumnStatisticsData",
        .date_column_statistics_data = "DateColumnStatisticsData",
        .decimal_column_statistics_data = "DecimalColumnStatisticsData",
        .double_column_statistics_data = "DoubleColumnStatisticsData",
        .long_column_statistics_data = "LongColumnStatisticsData",
        .string_column_statistics_data = "StringColumnStatisticsData",
        .type = "Type",
    };
};
