const ValueType = @import("value_type.zig").ValueType;

/// Contains information relating to dates in a document, including the type
/// of value, and the value.
pub const NormalizedValue = struct {
    /// The value of the date, written as Year-Month-DayTHour:Minute:Second.
    value: ?[]const u8,

    /// The normalized type of the value detected. In this case, DATE.
    value_type: ?ValueType,

    pub const json_field_names = .{
        .value = "Value",
        .value_type = "ValueType",
    };
};
