const PivotTableFieldCollapseState = @import("pivot_table_field_collapse_state.zig").PivotTableFieldCollapseState;
const PivotTableFieldCollapseStateTarget = @import("pivot_table_field_collapse_state_target.zig").PivotTableFieldCollapseStateTarget;

/// The collapse state options for the pivot table field options.
pub const PivotTableFieldCollapseStateOption = struct {
    /// The state of the field target of a pivot table. Choose one of the following
    /// options:
    ///
    /// * `COLLAPSED`
    ///
    /// * `EXPANDED`
    state: ?PivotTableFieldCollapseState = null,

    /// A tagged-union object that sets the collapse state.
    target: PivotTableFieldCollapseStateTarget,

    pub const json_field_names = .{
        .state = "State",
        .target = "Target",
    };
};
