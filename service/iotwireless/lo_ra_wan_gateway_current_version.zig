const LoRaWANGatewayVersion = @import("lo_ra_wan_gateway_version.zig").LoRaWANGatewayVersion;

/// LoRaWANGatewayCurrentVersion object.
pub const LoRaWANGatewayCurrentVersion = struct {
    /// The version of the gateways that should receive the update.
    current_version: ?LoRaWANGatewayVersion = null,

    pub const json_field_names = .{
        .current_version = "CurrentVersion",
    };
};
