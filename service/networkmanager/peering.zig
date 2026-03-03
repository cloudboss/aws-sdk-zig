const PeeringError = @import("peering_error.zig").PeeringError;
const PeeringType = @import("peering_type.zig").PeeringType;
const PeeringState = @import("peering_state.zig").PeeringState;
const Tag = @import("tag.zig").Tag;

/// Describes a peering connection.
pub const Peering = struct {
    /// The ARN of a core network.
    core_network_arn: ?[]const u8 = null,

    /// The ID of the core network for the peering request.
    core_network_id: ?[]const u8 = null,

    /// The timestamp when the attachment peer was created.
    created_at: ?i64 = null,

    /// The edge location for the peer.
    edge_location: ?[]const u8 = null,

    /// Describes the error associated with the Connect peer request.
    last_modification_errors: ?[]const PeeringError = null,

    /// The ID of the account owner.
    owner_account_id: ?[]const u8 = null,

    /// The ID of the peering attachment.
    peering_id: ?[]const u8 = null,

    /// The type of peering. This will be `TRANSIT_GATEWAY`.
    peering_type: ?PeeringType = null,

    /// The resource ARN of the peer.
    resource_arn: ?[]const u8 = null,

    /// The current state of the peering connection.
    state: ?PeeringState = null,

    /// The list of key-value tags associated with the peering.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .core_network_arn = "CoreNetworkArn",
        .core_network_id = "CoreNetworkId",
        .created_at = "CreatedAt",
        .edge_location = "EdgeLocation",
        .last_modification_errors = "LastModificationErrors",
        .owner_account_id = "OwnerAccountId",
        .peering_id = "PeeringId",
        .peering_type = "PeeringType",
        .resource_arn = "ResourceArn",
        .state = "State",
        .tags = "Tags",
    };
};
