const DimensionValueType = @import("dimension_value_type.zig").DimensionValueType;

/// Represents the metadata attributes of the time series. For example, the name
/// and
/// Availability Zone of an EC2 instance or the name of the manufacturer of a
/// wind turbine are
/// dimensions.
pub const Dimension = struct {
    /// The data type of the dimension for the time-series data point.
    dimension_value_type: ?DimensionValueType = null,

    /// Dimension represents the metadata attributes of the time series. For
    /// example, the name
    /// and Availability Zone of an EC2 instance or the name of the manufacturer of
    /// a wind turbine
    /// are dimensions.
    ///
    /// For constraints on dimension names, see [Naming
    /// Constraints](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html#limits.naming).
    name: []const u8,

    /// The value of the dimension.
    value: []const u8,

    pub const json_field_names = .{
        .dimension_value_type = "DimensionValueType",
        .name = "Name",
        .value = "Value",
    };
};
