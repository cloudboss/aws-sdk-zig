const LogAnomalyClass = @import("log_anomaly_class.zig").LogAnomalyClass;

/// A cluster of similar anomalous log events found within a log group.
pub const LogAnomalyShowcase = struct {
    /// A list of anomalous log events that may be related.
    log_anomaly_classes: ?[]const LogAnomalyClass,

    pub const json_field_names = .{
        .log_anomaly_classes = "LogAnomalyClasses",
    };
};
