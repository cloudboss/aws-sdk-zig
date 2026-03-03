const ConnectPeerConfiguration = @import("connect_peer_configuration.zig").ConnectPeerConfiguration;
const ConnectPeerError = @import("connect_peer_error.zig").ConnectPeerError;
const ConnectPeerState = @import("connect_peer_state.zig").ConnectPeerState;
const Tag = @import("tag.zig").Tag;

/// Describes a core network Connect peer.
pub const ConnectPeer = struct {
    /// The configuration of the Connect peer.
    configuration: ?ConnectPeerConfiguration = null,

    /// The ID of the attachment to connect.
    connect_attachment_id: ?[]const u8 = null,

    /// The ID of the Connect peer.
    connect_peer_id: ?[]const u8 = null,

    /// The ID of a core network.
    core_network_id: ?[]const u8 = null,

    /// The timestamp when the Connect peer was created.
    created_at: ?i64 = null,

    /// The Connect peer Regions where edges are located.
    edge_location: ?[]const u8 = null,

    /// Describes the error associated with the attachment request.
    last_modification_errors: ?[]const ConnectPeerError = null,

    /// The state of the Connect peer.
    state: ?ConnectPeerState = null,

    /// The subnet ARN for the Connect peer. This only applies only when the
    /// protocol is NO_ENCAP.
    subnet_arn: ?[]const u8 = null,

    /// The list of key-value tags associated with the Connect peer.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .connect_attachment_id = "ConnectAttachmentId",
        .connect_peer_id = "ConnectPeerId",
        .core_network_id = "CoreNetworkId",
        .created_at = "CreatedAt",
        .edge_location = "EdgeLocation",
        .last_modification_errors = "LastModificationErrors",
        .state = "State",
        .subnet_arn = "SubnetArn",
        .tags = "Tags",
    };
};
