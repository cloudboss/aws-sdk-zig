const MinimumThroughputBillingCommitmentInputStatus = @import("minimum_throughput_billing_commitment_input_status.zig").MinimumThroughputBillingCommitmentInputStatus;

/// Represents the request parameters for configuring minimum throughput billing
/// commitment.
///
/// * Minimum throughput billing commitments provide cost savings on on-demand
///   data streams in exchange for committing to a minimum level of throughput
///   usage.
///
/// * Commitments have a minimum duration of 24 hours that must be honored
///   before they can be disabled.
///
/// * If you attempt to disable a commitment before the minimum commitment
///   period ends, the commitment will be scheduled for automatic disable at the
///   earliest allowed end time.
///
/// * You can cancel a pending disable by enabling the commitment again before
///   the earliest allowed end time.
pub const MinimumThroughputBillingCommitmentInput = struct {
    /// The desired status of the minimum throughput billing commitment.
    status: MinimumThroughputBillingCommitmentInputStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
