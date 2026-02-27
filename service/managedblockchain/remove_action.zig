/// An action to remove a member from a Managed Blockchain network as the result
/// of a removal proposal that is `APPROVED`. The member and all associated
/// resources are deleted from the network.
///
/// Applies only to Hyperledger Fabric.
pub const RemoveAction = struct {
    /// The unique identifier of the member to remove.
    member_id: []const u8,

    pub const json_field_names = .{
        .member_id = "MemberId",
    };
};
