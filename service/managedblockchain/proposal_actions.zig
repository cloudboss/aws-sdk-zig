const InviteAction = @import("invite_action.zig").InviteAction;
const RemoveAction = @import("remove_action.zig").RemoveAction;

/// The actions to carry out if a proposal is `APPROVED`.
///
/// Applies only to Hyperledger Fabric.
pub const ProposalActions = struct {
    /// The actions to perform for an `APPROVED` proposal to invite an Amazon Web
    /// Services account to create a member and join the network.
    invitations: ?[]const InviteAction = null,

    /// The actions to perform for an `APPROVED` proposal to remove a member from
    /// the network, which deletes the member and all associated member resources
    /// from the network.
    removals: ?[]const RemoveAction = null,

    pub const json_field_names = .{
        .invitations = "Invitations",
        .removals = "Removals",
    };
};
