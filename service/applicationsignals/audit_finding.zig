const aws = @import("aws");

const AuditorResult = @import("auditor_result.zig").AuditorResult;
const DependencyGraph = @import("dependency_graph.zig").DependencyGraph;
const MetricGraph = @import("metric_graph.zig").MetricGraph;

/// A structure that contains information about an audit finding, which
/// represents an automated analysis result about service behavior, performance
/// issues, or potential problems identified through heuristic algorithms.
pub const AuditFinding = struct {
    /// An array of auditor results that contain the specific findings,
    /// descriptions, and severity levels identified by different auditing
    /// algorithms.
    auditor_results: ?[]const AuditorResult = null,

    /// A structure containing nodes and edges that represent the dependency
    /// relationships relevant to this audit finding, helping to understand the
    /// context and potential impact.
    dependency_graph: ?DependencyGraph = null,

    /// The key attributes that identify the service or entity this audit finding
    /// relates to. This is a string-to-string map that includes fields like Type,
    /// Name, and Environment.
    key_attributes: []const aws.map.StringMapEntry,

    /// A structure containing metric data queries and time range information that
    /// provides context for the audit finding through relevant performance metrics.
    metric_graph: ?MetricGraph = null,

    /// The name of the operation associated with this audit finding, if the finding
    /// is specific to a particular service operation.
    operation: ?[]const u8 = null,

    /// The type of audit finding.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .auditor_results = "AuditorResults",
        .dependency_graph = "DependencyGraph",
        .key_attributes = "KeyAttributes",
        .metric_graph = "MetricGraph",
        .operation = "Operation",
        .@"type" = "Type",
    };
};
