const CallAnalyticsSkippedFeature = @import("call_analytics_skipped_feature.zig").CallAnalyticsSkippedFeature;

/// Contains details about a call analytics job, including information about
/// skipped analytics features.
pub const CallAnalyticsJobDetails = struct {
    /// Contains information about any skipped analytics features during the
    /// analysis of a call analytics job.
    ///
    /// This array lists all the analytics features that were skipped, along with
    /// their corresponding reason code and message.
    skipped: ?[]const CallAnalyticsSkippedFeature = null,

    pub const json_field_names = .{
        .skipped = "Skipped",
    };
};
