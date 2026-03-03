const AgentQualityMetrics = @import("agent_quality_metrics.zig").AgentQualityMetrics;
const CustomerQualityMetrics = @import("customer_quality_metrics.zig").CustomerQualityMetrics;

/// Information about the quality of the participant's media connection.
pub const QualityMetrics = struct {
    /// Information about the quality of Agent media connection.
    agent: ?AgentQualityMetrics = null,

    /// Information about the quality of Customer media connection.
    customer: ?CustomerQualityMetrics = null,

    pub const json_field_names = .{
        .agent = "Agent",
        .customer = "Customer",
    };
};
