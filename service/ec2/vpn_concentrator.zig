const Tag = @import("tag.zig").Tag;

/// Describes a VPN concentrator.
pub const VpnConcentrator = struct {
    /// The current state of the VPN concentrator.
    state: ?[]const u8,

    /// Any tags assigned to the VPN concentrator.
    tags: ?[]const Tag,

    /// The ID of the transit gateway attachment for the VPN concentrator.
    transit_gateway_attachment_id: ?[]const u8,

    /// The ID of the transit gateway associated with the VPN concentrator.
    transit_gateway_id: ?[]const u8,

    /// The type of VPN concentrator.
    @"type": ?[]const u8,

    /// The ID of the VPN concentrator.
    vpn_concentrator_id: ?[]const u8,
};
