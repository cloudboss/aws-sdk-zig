/// An alert action taken to light up an icon on the Amazon SageMaker Model
/// Dashboard when an alert goes into `InAlert` status.
pub const ModelDashboardIndicatorAction = struct {
    /// Indicates whether the alert action is turned on.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
