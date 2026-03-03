const FilterField = @import("filter_field.zig").FilterField;
const Operator = @import("operator.zig").Operator;

/// Contains the filter to apply to requests. You can specify up to 10 filters
/// for a request.
pub const Filter = struct {
    /// Name of the filter to use.
    ///
    /// **Supported filters**
    ///
    /// The supported filters for ListSessions are: `ActionName`, `SessionStatus`,
    /// and `InitationTime`.
    field_name: ?FilterField = null,

    /// Operator to use for filtering.
    ///
    /// * `EQ`: Equal to the specified value
    /// * `NE`: Not equal to the specified value
    /// * `GT`: Greater than the specified value
    /// * `LT`: Less than the specified value
    /// * `GTE`: Greater than or equal to the specified value
    /// * `LTE`: Less than or equal to the specified value
    /// * `CONTAINS`: Contains the specified value
    /// * `NOT_CONTAINS`: Does not contain the specified value
    /// * `BETWEEN`: Between two values, inclusive of the specified values.
    ///
    /// **Supported operators for each filter**:
    ///
    /// * `ActionName`: `EQ` | `NE` | `CONTAINS` | `NOT_CONTAINS`
    /// * `SessionStatus`: `EQ` | `NE`
    /// * `InitiationTime`: `GT` | `LT` | `GTE` | `LTE` | `BETWEEN`
    operator: ?Operator = null,

    /// Value to use for filtering. For the `BETWEEN` operator, specify values in
    /// the format `a AND b` (`AND` is case-insensitive).
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .operator = "Operator",
        .value = "Value",
    };
};
