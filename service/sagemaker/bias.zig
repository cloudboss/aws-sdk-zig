const MetricsSource = @import("metrics_source.zig").MetricsSource;

/// Contains bias metrics for a model.
pub const Bias = struct {
    /// The post-training bias report for a model.
    post_training_report: ?MetricsSource = null,

    /// The pre-training bias report for a model.
    pre_training_report: ?MetricsSource = null,

    /// The bias report for a model
    report: ?MetricsSource = null,

    pub const json_field_names = .{
        .post_training_report = "PostTrainingReport",
        .pre_training_report = "PreTrainingReport",
        .report = "Report",
    };
};
