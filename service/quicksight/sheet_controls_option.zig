const DashboardUIState = @import("dashboard_ui_state.zig").DashboardUIState;

/// Sheet controls option.
pub const SheetControlsOption = struct {
    /// Visibility state.
    visibility_state: ?DashboardUIState,

    pub const json_field_names = .{
        .visibility_state = "VisibilityState",
    };
};
