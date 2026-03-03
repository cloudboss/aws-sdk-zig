const MinimumThroughputBillingCommitmentOutputStatus = @import("minimum_throughput_billing_commitment_output_status.zig").MinimumThroughputBillingCommitmentOutputStatus;

/// Represents the current status of minimum throughput billing commitment for
/// an account.
pub const MinimumThroughputBillingCommitmentOutput = struct {
    /// The earliest timestamp when the commitment can be ended.
    earliest_allowed_end_at: ?i64 = null,

    /// The timestamp when the commitment was ended.
    ended_at: ?i64 = null,

    /// The timestamp when the commitment was started.
    started_at: ?i64 = null,

    /// The current status of the minimum throughput billing commitment.
    status: MinimumThroughputBillingCommitmentOutputStatus,

    pub const json_field_names = .{
        .earliest_allowed_end_at = "EarliestAllowedEndAt",
        .ended_at = "EndedAt",
        .started_at = "StartedAt",
        .status = "Status",
    };
};
