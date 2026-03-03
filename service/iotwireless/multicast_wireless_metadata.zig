const LoRaWANMulticastMetadata = @import("lo_ra_wan_multicast_metadata.zig").LoRaWANMulticastMetadata;

/// Wireless metadata that is to be sent to multicast group.
pub const MulticastWirelessMetadata = struct {
    lo_ra_wan: ?LoRaWANMulticastMetadata = null,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
    };
};
