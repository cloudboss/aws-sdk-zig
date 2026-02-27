const ModelDashboardIndicatorAction = @import("model_dashboard_indicator_action.zig").ModelDashboardIndicatorAction;

/// A list of alert actions taken in response to an alert going into `InAlert`
/// status.
pub const MonitoringAlertActions = struct {
    /// An alert action taken to light up an icon on the Model Dashboard when an
    /// alert goes into `InAlert` status.
    model_dashboard_indicator: ?ModelDashboardIndicatorAction,

    pub const json_field_names = .{
        .model_dashboard_indicator = "ModelDashboardIndicator",
    };
};
