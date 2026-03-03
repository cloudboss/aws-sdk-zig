const ProposalStatus = @import("proposal_status.zig").ProposalStatus;

/// Properties of a proposal.
///
/// Applies only to Hyperledger Fabric.
pub const ProposalSummary = struct {
    /// The Amazon Resource Name (ARN) of the proposal. For more information about
    /// ARNs and their format, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The date and time that the proposal was created.
    creation_date: ?i64 = null,

    /// The description of the proposal.
    description: ?[]const u8 = null,

    /// The date and time that the proposal expires. This is the `CreationDate` plus
    /// the `ProposalDurationInHours` that is specified in the
    /// `ProposalThresholdPolicy`. After this date and time, if members haven't cast
    /// enough votes to determine the outcome according to the voting policy, the
    /// proposal is `EXPIRED` and `Actions` aren't carried out.
    expiration_date: ?i64 = null,

    /// The unique identifier of the proposal.
    proposal_id: ?[]const u8 = null,

    /// The unique identifier of the member that created the proposal.
    proposed_by_member_id: ?[]const u8 = null,

    /// The name of the member that created the proposal.
    proposed_by_member_name: ?[]const u8 = null,

    /// The status of the proposal. Values are as follows:
    ///
    /// * `IN_PROGRESS` - The proposal is active and open for member voting.
    ///
    /// * `APPROVED` - The proposal was approved with sufficient `YES` votes among
    ///   members according to the `VotingPolicy` specified for the `Network`. The
    ///   specified proposal actions are carried out.
    ///
    /// * `REJECTED` - The proposal was rejected with insufficient `YES` votes among
    ///   members according to the `VotingPolicy` specified for the `Network`. The
    ///   specified `ProposalActions` aren't carried out.
    ///
    /// * `EXPIRED` - Members didn't cast the number of votes required to determine
    ///   the proposal outcome before the proposal expired. The specified
    ///   `ProposalActions` aren't carried out.
    ///
    /// * `ACTION_FAILED` - One or more of the specified `ProposalActions` in a
    ///   proposal that was approved couldn't be completed because of an error.
    status: ?ProposalStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .description = "Description",
        .expiration_date = "ExpirationDate",
        .proposal_id = "ProposalId",
        .proposed_by_member_id = "ProposedByMemberId",
        .proposed_by_member_name = "ProposedByMemberName",
        .status = "Status",
    };
};
