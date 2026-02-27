const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// An object containing additional settings for your VDM configuration as
/// applicable to
/// the Dashboard.
pub const DashboardOptions = struct {
    /// Specifies the status of your VDM engagement metrics collection. Can be one
    /// of the
    /// following:
    ///
    /// * `ENABLED` – Amazon SES enables engagement metrics for the
    /// configuration set.
    ///
    /// * `DISABLED` – Amazon SES disables engagement metrics for the
    /// configuration set.
    engagement_metrics: ?FeatureStatus,

    pub const json_field_names = .{
        .engagement_metrics = "EngagementMetrics",
    };
};
