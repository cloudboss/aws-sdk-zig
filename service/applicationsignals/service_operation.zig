const MetricReference = @import("metric_reference.zig").MetricReference;

/// This structure contains information about an operation discovered by
/// Application Signals. An operation is a specific function performed by a
/// service that was discovered by Application Signals, and is often an API that
/// is called by an upstream dependent.
pub const ServiceOperation = struct {
    /// An array of structures that each contain information about one metric
    /// associated with this service operation that was discovered by Application
    /// Signals.
    metric_references: []const MetricReference,

    /// The name of the operation, discovered by Application Signals.
    name: []const u8,

    pub const json_field_names = .{
        .metric_references = "MetricReferences",
        .name = "Name",
    };
};
