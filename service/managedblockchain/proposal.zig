const aws = @import("aws");

const ProposalActions = @import("proposal_actions.zig").ProposalActions;
const ProposalStatus = @import("proposal_status.zig").ProposalStatus;

/// Properties of a proposal on a Managed Blockchain network.
///
/// Applies only to Hyperledger Fabric.
pub const Proposal = struct {
    /// The actions to perform on the network if the proposal is `APPROVED`.
    actions: ?ProposalActions = null,

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

    /// The unique identifier of the network for which the proposal is made.
    network_id: ?[]const u8 = null,

    /// The current total of `NO` votes cast on the proposal by members.
    no_vote_count: ?i32 = null,

    /// The number of votes remaining to be cast on the proposal by members. In
    /// other words, the number of members minus the sum of `YES` votes and `NO`
    /// votes.
    outstanding_vote_count: ?i32 = null,

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
    ///   proposal that was approved couldn't be completed because of an error. The
    ///   `ACTION_FAILED` status occurs even if only one ProposalAction fails and
    ///   other actions are successful.
    status: ?ProposalStatus = null,

    /// Tags assigned to the proposal. Each tag consists of a key and optional
    /// value.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The current total of `YES` votes cast on the proposal by members.
    yes_vote_count: ?i32 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .arn = "Arn",
        .creation_date = "CreationDate",
        .description = "Description",
        .expiration_date = "ExpirationDate",
        .network_id = "NetworkId",
        .no_vote_count = "NoVoteCount",
        .outstanding_vote_count = "OutstandingVoteCount",
        .proposal_id = "ProposalId",
        .proposed_by_member_id = "ProposedByMemberId",
        .proposed_by_member_name = "ProposedByMemberName",
        .status = "Status",
        .tags = "Tags",
        .yes_vote_count = "YesVoteCount",
    };
};
