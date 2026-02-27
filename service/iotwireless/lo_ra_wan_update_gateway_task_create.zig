const LoRaWANGatewayVersion = @import("lo_ra_wan_gateway_version.zig").LoRaWANGatewayVersion;

/// LoRaWANUpdateGatewayTaskCreate object.
pub const LoRaWANUpdateGatewayTaskCreate = struct {
    /// The version of the gateways that should receive the update.
    current_version: ?LoRaWANGatewayVersion,

    /// The CRC of the signature private key to check.
    sig_key_crc: ?i64,

    /// The signature used to verify the update firmware.
    update_signature: ?[]const u8,

    /// The firmware version to update the gateway to.
    update_version: ?LoRaWANGatewayVersion,

    pub const json_field_names = .{
        .current_version = "CurrentVersion",
        .sig_key_crc = "SigKeyCrc",
        .update_signature = "UpdateSignature",
        .update_version = "UpdateVersion",
    };
};
