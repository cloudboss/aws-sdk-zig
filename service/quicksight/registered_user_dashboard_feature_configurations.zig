const AmazonQInQuickSightDashboardConfigurations = @import("amazon_q_in_quick_sight_dashboard_configurations.zig").AmazonQInQuickSightDashboardConfigurations;
const BookmarksConfigurations = @import("bookmarks_configurations.zig").BookmarksConfigurations;
const RecentSnapshotsConfigurations = @import("recent_snapshots_configurations.zig").RecentSnapshotsConfigurations;
const SchedulesConfigurations = @import("schedules_configurations.zig").SchedulesConfigurations;
const SharedViewConfigurations = @import("shared_view_configurations.zig").SharedViewConfigurations;
const StatePersistenceConfigurations = @import("state_persistence_configurations.zig").StatePersistenceConfigurations;
const ThresholdAlertsConfigurations = @import("threshold_alerts_configurations.zig").ThresholdAlertsConfigurations;

/// The feature configuration for an embedded dashboard.
pub const RegisteredUserDashboardFeatureConfigurations = struct {
    /// The Amazon Q configurations of an embedded Amazon Quick Sight
    /// dashboard.
    amazon_q_in_quick_sight: ?AmazonQInQuickSightDashboardConfigurations,

    /// The bookmarks configuration for an embedded dashboard in Amazon Quick Sight.
    bookmarks: ?BookmarksConfigurations,

    /// The recent snapshots configuration for an Quick Sight embedded dashboard
    recent_snapshots: ?RecentSnapshotsConfigurations,

    /// The schedules configuration for an embedded Quick Sight dashboard.
    schedules: ?SchedulesConfigurations,

    /// The shared view settings of an embedded dashboard.
    shared_view: ?SharedViewConfigurations,

    /// The state persistence settings of an embedded dashboard.
    state_persistence: ?StatePersistenceConfigurations,

    /// The threshold alerts configuration for an Quick Sight embedded dashboard.
    threshold_alerts: ?ThresholdAlertsConfigurations,

    pub const json_field_names = .{
        .amazon_q_in_quick_sight = "AmazonQInQuickSight",
        .bookmarks = "Bookmarks",
        .recent_snapshots = "RecentSnapshots",
        .schedules = "Schedules",
        .shared_view = "SharedView",
        .state_persistence = "StatePersistence",
        .threshold_alerts = "ThresholdAlerts",
    };
};
