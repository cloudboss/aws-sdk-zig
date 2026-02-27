const LoRaWANSendDataToDevice = @import("lo_ra_wan_send_data_to_device.zig").LoRaWANSendDataToDevice;
const SidewalkSendDataToDevice = @import("sidewalk_send_data_to_device.zig").SidewalkSendDataToDevice;

/// WirelessMetadata object.
pub const WirelessMetadata = struct {
    /// LoRaWAN device info.
    lo_ra_wan: ?LoRaWANSendDataToDevice,

    /// The Sidewalk account credentials.
    sidewalk: ?SidewalkSendDataToDevice,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
        .sidewalk = "Sidewalk",
    };
};
