const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;

/// Defines the compliance against the resiliency policy for a disruption.
pub const DisruptionCompliance = struct {
    /// The Recovery Point Objective (RPO) that is achievable, in seconds.
    achievable_rpo_in_secs: i32 = 0,

    /// The Recovery Time Objective (RTO) that is achievable, in seconds
    achievable_rto_in_secs: i32 = 0,

    /// The current status of compliance for the resiliency policy.
    compliance_status: ComplianceStatus,

    /// The current RPO, in seconds.
    current_rpo_in_secs: i32 = 0,

    /// The current RTO, in seconds.
    current_rto_in_secs: i32 = 0,

    /// The disruption compliance message.
    message: ?[]const u8,

    /// The RPO description.
    rpo_description: ?[]const u8,

    /// Reference identifier of the RPO .
    rpo_reference_id: ?[]const u8,

    /// The RTO description.
    rto_description: ?[]const u8,

    /// Reference identifier of the RTO.
    rto_reference_id: ?[]const u8,

    pub const json_field_names = .{
        .achievable_rpo_in_secs = "achievableRpoInSecs",
        .achievable_rto_in_secs = "achievableRtoInSecs",
        .compliance_status = "complianceStatus",
        .current_rpo_in_secs = "currentRpoInSecs",
        .current_rto_in_secs = "currentRtoInSecs",
        .message = "message",
        .rpo_description = "rpoDescription",
        .rpo_reference_id = "rpoReferenceId",
        .rto_description = "rtoDescription",
        .rto_reference_id = "rtoReferenceId",
    };
};
