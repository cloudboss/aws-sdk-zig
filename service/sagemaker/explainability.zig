const MetricsSource = @import("metrics_source.zig").MetricsSource;

/// Contains explainability metrics for a model.
pub const Explainability = struct {
    /// The explainability report for a model.
    report: ?MetricsSource = null,

    pub const json_field_names = .{
        .report = "Report",
    };
};
