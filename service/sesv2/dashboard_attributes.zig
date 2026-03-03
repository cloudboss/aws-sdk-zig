const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// An object containing additional settings for your VDM configuration as
/// applicable to
/// the Dashboard.
pub const DashboardAttributes = struct {
    /// Specifies the status of your VDM engagement metrics collection. Can be one
    /// of the
    /// following:
    ///
    /// * `ENABLED` – Amazon SES enables engagement metrics for your
    /// account.
    ///
    /// * `DISABLED` – Amazon SES disables engagement metrics for your
    /// account.
    engagement_metrics: ?FeatureStatus = null,

    pub const json_field_names = .{
        .engagement_metrics = "EngagementMetrics",
    };
};
