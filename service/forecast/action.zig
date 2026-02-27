const Operation = @import("operation.zig").Operation;

/// Defines the modifications that you are making to an attribute for a what-if
/// forecast. For example, you can use this operation to create a what-if
/// forecast that investigates a 10% off sale on all shoes. To do this, you
/// specify `"AttributeName": "shoes"`, `"Operation": "MULTIPLY"`, and `"Value":
/// "0.90"`. Pair this operation with the TimeSeriesCondition operation within
/// the CreateWhatIfForecastRequest$TimeSeriesTransformations operation to
/// define a subset of attribute items that are modified.
pub const Action = struct {
    /// The related time series that you are modifying. This value is case
    /// insensitive.
    attribute_name: []const u8,

    /// The operation that is applied to the provided attribute. Operations include:
    ///
    /// * `ADD` - adds `Value` to all rows of `AttributeName`.
    ///
    /// * `SUBTRACT` - subtracts `Value` from all rows of `AttributeName`.
    ///
    /// * `MULTIPLY` - multiplies all rows of `AttributeName` by `Value`.
    ///
    /// * `DIVIDE` - divides all rows of `AttributeName` by `Value`.
    operation: Operation,

    /// The value that is applied for the chosen `Operation`.
    value: f64,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .operation = "Operation",
        .value = "Value",
    };
};
