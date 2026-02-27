const Condition = @import("condition.zig").Condition;

/// Creates a subset of items within an attribute that are modified. For
/// example, you can use this operation to create a subset of items that cost $5
/// or less. To do this, you specify `"AttributeName": "price"`,
/// `"AttributeValue": "5"`, and `"Condition": "LESS_THAN"`. Pair this operation
/// with the Action operation within the
/// CreateWhatIfForecastRequest$TimeSeriesTransformations operation to define
/// how the attribute is modified.
pub const TimeSeriesCondition = struct {
    /// The item_id, dimension name, IM name, or timestamp that you are modifying.
    attribute_name: []const u8,

    /// The value that is applied for the chosen `Condition`.
    attribute_value: []const u8,

    /// The condition to apply. Valid values are `EQUALS`, `NOT_EQUALS`, `LESS_THAN`
    /// and
    /// `GREATER_THAN`.
    condition: Condition,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .attribute_value = "AttributeValue",
        .condition = "Condition",
    };
};
