const CallAnalyticsFeature = @import("call_analytics_feature.zig").CallAnalyticsFeature;
const CallAnalyticsSkippedReasonCode = @import("call_analytics_skipped_reason_code.zig").CallAnalyticsSkippedReasonCode;

/// Represents a skipped analytics feature during the analysis of a call
/// analytics job.
///
/// The `Feature` field indicates the type of analytics feature that was
/// skipped.
///
/// The `Message` field contains additional information or a message explaining
/// why the analytics feature was skipped.
///
/// The `ReasonCode` field provides a code indicating the reason why the
/// analytics feature was skipped.
pub const CallAnalyticsSkippedFeature = struct {
    /// Indicates the type of analytics feature that was skipped during the analysis
    /// of a call analytics job.
    feature: ?CallAnalyticsFeature = null,

    /// Contains additional information or a message explaining why a specific
    /// analytics feature was skipped during the analysis of a call analytics job.
    message: ?[]const u8 = null,

    /// Provides a code indicating the reason why a specific analytics feature was
    /// skipped during the analysis of a call analytics job.
    reason_code: ?CallAnalyticsSkippedReasonCode = null,

    pub const json_field_names = .{
        .feature = "Feature",
        .message = "Message",
        .reason_code = "ReasonCode",
    };
};
