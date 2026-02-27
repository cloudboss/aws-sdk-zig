const ConnectPeerState = @import("connect_peer_state.zig").ConnectPeerState;
const Tag = @import("tag.zig").Tag;

/// Summary description of a Connect peer.
pub const ConnectPeerSummary = struct {
    /// The ID of a Connect peer attachment.
    connect_attachment_id: ?[]const u8,

    /// The ID of a Connect peer.
    connect_peer_id: ?[]const u8,

    /// The state of a Connect peer.
    connect_peer_state: ?ConnectPeerState,

    /// The ID of a core network.
    core_network_id: ?[]const u8,

    /// The timestamp when a Connect peer was created.
    created_at: ?i64,

    /// The Region where the edge is located.
    edge_location: ?[]const u8,

    /// The subnet ARN for the Connect peer summary.
    subnet_arn: ?[]const u8,

    /// The list of key-value tags associated with the Connect peer summary.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .connect_attachment_id = "ConnectAttachmentId",
        .connect_peer_id = "ConnectPeerId",
        .connect_peer_state = "ConnectPeerState",
        .core_network_id = "CoreNetworkId",
        .created_at = "CreatedAt",
        .edge_location = "EdgeLocation",
        .subnet_arn = "SubnetArn",
        .tags = "Tags",
    };
};
