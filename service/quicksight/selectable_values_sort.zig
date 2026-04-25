const ControlSortDirection = @import("control_sort_direction.zig").ControlSortDirection;

/// The sort configuration for selectable values in a control.
pub const SelectableValuesSort = struct {
    /// The sort direction for the selectable values. Choose one of the following
    /// options:
    ///
    /// * `ASC`: Sort in ascending order.
    ///
    /// * `DESC`: Sort in descending order.
    ///
    /// * `USER_DEFINED_ORDER`: Preserve the order in which the values were entered.
    direction: ControlSortDirection,

    pub const json_field_names = .{
        .direction = "Direction",
    };
};
