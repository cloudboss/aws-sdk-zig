/// Information about the transit gateway in the peering attachment.
pub const PeeringTgwInfo = struct {
    /// The ID of the core network where the transit gateway peer is located.
    core_network_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the transit gateway.
    owner_id: ?[]const u8,

    /// The Region of the transit gateway.
    region: ?[]const u8,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8,
};
