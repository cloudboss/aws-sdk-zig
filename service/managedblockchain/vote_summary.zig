const VoteValue = @import("vote_value.zig").VoteValue;

/// Properties of an individual vote that a member cast for a proposal.
///
/// Applies only to Hyperledger Fabric.
pub const VoteSummary = struct {
    /// The unique identifier of the member that cast the vote.
    member_id: ?[]const u8 = null,

    /// The name of the member that cast the vote.
    member_name: ?[]const u8 = null,

    /// The vote value, either `YES` or `NO`.
    vote: ?VoteValue = null,

    pub const json_field_names = .{
        .member_id = "MemberId",
        .member_name = "MemberName",
        .vote = "Vote",
    };
};
