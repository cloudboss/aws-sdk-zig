const ThresholdComparator = @import("threshold_comparator.zig").ThresholdComparator;

/// A policy type that defines the voting rules for the network. The rules
/// decide if a proposal is approved. Approval may be based on criteria such as
/// the percentage of `YES` votes and the duration of the proposal. The policy
/// applies to all proposals and is specified when the network is created.
///
/// Applies only to Hyperledger Fabric.
pub const ApprovalThresholdPolicy = struct {
    /// The duration from the time that a proposal is created until it expires. If
    /// members cast neither the required number of `YES` votes to approve the
    /// proposal nor the number of `NO` votes required to reject it before the
    /// duration expires, the proposal is `EXPIRED` and `ProposalActions` aren't
    /// carried out.
    proposal_duration_in_hours: ?i32,

    /// Determines whether the vote percentage must be greater than the
    /// `ThresholdPercentage` or must be greater than or equal to the
    /// `ThresholdPercentage` to be approved.
    threshold_comparator: ?ThresholdComparator,

    /// The percentage of votes among all members that must be `YES` for a proposal
    /// to be approved. For example, a `ThresholdPercentage` value of `50` indicates
    /// 50%. The `ThresholdComparator` determines the precise comparison. If a
    /// `ThresholdPercentage` value of `50` is specified on a network with 10
    /// members, along with a `ThresholdComparator` value of `GREATER_THAN`, this
    /// indicates that 6 `YES` votes are required for the proposal to be approved.
    threshold_percentage: ?i32,

    pub const json_field_names = .{
        .proposal_duration_in_hours = "ProposalDurationInHours",
        .threshold_comparator = "ThresholdComparator",
        .threshold_percentage = "ThresholdPercentage",
    };
};
