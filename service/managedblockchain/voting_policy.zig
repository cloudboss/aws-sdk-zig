const ApprovalThresholdPolicy = @import("approval_threshold_policy.zig").ApprovalThresholdPolicy;

/// The voting rules for the network to decide if a proposal is accepted
///
/// Applies only to Hyperledger Fabric.
pub const VotingPolicy = struct {
    /// Defines the rules for the network for voting on proposals, such as the
    /// percentage of `YES` votes required for the proposal to be approved and the
    /// duration of the proposal. The policy applies to all proposals and is
    /// specified when the network is created.
    approval_threshold_policy: ?ApprovalThresholdPolicy,

    pub const json_field_names = .{
        .approval_threshold_policy = "ApprovalThresholdPolicy",
    };
};
