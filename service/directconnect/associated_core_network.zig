/// The Amazon Web Services Cloud WAN core network that the Direct Connect
/// gateway is associated to. This is only returned when a Direct Connect
/// gateway is associated to a Cloud WAN core network.
pub const AssociatedCoreNetwork = struct {
    /// the ID of the Direct Connect gateway attachment.
    attachment_id: ?[]const u8,

    /// The ID of the Cloud WAN core network that the Direct Connect gateway is
    /// associated to.
    id: ?[]const u8,

    /// The account owner of the Cloud WAN core network.
    owner_account: ?[]const u8,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .id = "id",
        .owner_account = "ownerAccount",
    };
};
