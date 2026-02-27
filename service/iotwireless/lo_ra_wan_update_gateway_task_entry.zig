const LoRaWANGatewayVersion = @import("lo_ra_wan_gateway_version.zig").LoRaWANGatewayVersion;

/// LoRaWANUpdateGatewayTaskEntry object.
pub const LoRaWANUpdateGatewayTaskEntry = struct {
    /// The version of the gateways that should receive the update.
    current_version: ?LoRaWANGatewayVersion,

    /// The firmware version to update the gateway to.
    update_version: ?LoRaWANGatewayVersion,

    pub const json_field_names = .{
        .current_version = "CurrentVersion",
        .update_version = "UpdateVersion",
    };
};
