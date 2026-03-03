const AmazonQInQuickSightConsoleConfigurations = @import("amazon_q_in_quick_sight_console_configurations.zig").AmazonQInQuickSightConsoleConfigurations;
const RecentSnapshotsConfigurations = @import("recent_snapshots_configurations.zig").RecentSnapshotsConfigurations;
const SchedulesConfigurations = @import("schedules_configurations.zig").SchedulesConfigurations;
const SharedViewConfigurations = @import("shared_view_configurations.zig").SharedViewConfigurations;
const StatePersistenceConfigurations = @import("state_persistence_configurations.zig").StatePersistenceConfigurations;
const ThresholdAlertsConfigurations = @import("threshold_alerts_configurations.zig").ThresholdAlertsConfigurations;

/// The feature configurations of an embedded Amazon Quick Sight console.
pub const RegisteredUserConsoleFeatureConfigurations = struct {
    /// The Amazon Q configurations of an embedded Amazon Quick Sight
    /// console.
    amazon_q_in_quick_sight: ?AmazonQInQuickSightConsoleConfigurations = null,

    /// The recent snapshots configuration for an embedded Quick Sight dashboard.
    recent_snapshots: ?RecentSnapshotsConfigurations = null,

    /// The schedules configuration for an embedded Quick Sight dashboard.
    schedules: ?SchedulesConfigurations = null,

    /// The shared view settings of an embedded dashboard.
    shared_view: ?SharedViewConfigurations = null,

    /// The state persistence configurations of an embedded Amazon Quick Sight
    /// console.
    state_persistence: ?StatePersistenceConfigurations = null,

    /// The threshold alerts configuration for an embedded Quick Sight dashboard.
    threshold_alerts: ?ThresholdAlertsConfigurations = null,

    pub const json_field_names = .{
        .amazon_q_in_quick_sight = "AmazonQInQuickSight",
        .recent_snapshots = "RecentSnapshots",
        .schedules = "Schedules",
        .shared_view = "SharedView",
        .state_persistence = "StatePersistence",
        .threshold_alerts = "ThresholdAlerts",
    };
};
