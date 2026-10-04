const ContentQualityAnalysisState = @import("content_quality_analysis_state.zig").ContentQualityAnalysisState;

/// Detects frozen video frames in the router input's source content and reports
/// them through a CloudWatch metric, an EventBridge event, and a router input
/// message.
pub const FrozenFramesConfiguration = struct {
    /// Indicates whether frozen frames detection is enabled or disabled.
    state: ContentQualityAnalysisState,

    /// The number of consecutive seconds of a frozen frame that MediaConnect must
    /// detect before it reports an issue.
    threshold_seconds: i32,

    pub const json_field_names = .{
        .state = "State",
        .threshold_seconds = "ThresholdSeconds",
    };
};
