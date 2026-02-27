/// An action to invite a specific Amazon Web Services account to create a
/// member and join the network. The `InviteAction` is carried out when a
/// `Proposal` is `APPROVED`.
///
/// Applies only to Hyperledger Fabric.
pub const InviteAction = struct {
    /// The Amazon Web Services account ID to invite.
    principal: []const u8,

    pub const json_field_names = .{
        .principal = "Principal",
    };
};
