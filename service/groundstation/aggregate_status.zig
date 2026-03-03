const aws = @import("aws");

const AgentStatus = @import("agent_status.zig").AgentStatus;

/// Aggregate status of Agent components.
pub const AggregateStatus = struct {
    /// Sparse map of failure signatures.
    signature_map: ?[]const aws.map.MapEntry(bool) = null,

    /// Aggregate status.
    status: AgentStatus,

    pub const json_field_names = .{
        .signature_map = "signatureMap",
        .status = "status",
    };
};
