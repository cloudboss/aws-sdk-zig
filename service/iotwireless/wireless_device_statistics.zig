const FuotaDeviceStatus = @import("fuota_device_status.zig").FuotaDeviceStatus;
const LoRaWANListDevice = @import("lo_ra_wan_list_device.zig").LoRaWANListDevice;
const PositioningConfigStatus = @import("positioning_config_status.zig").PositioningConfigStatus;
const SidewalkListDevice = @import("sidewalk_list_device.zig").SidewalkListDevice;
const WirelessDeviceType = @import("wireless_device_type.zig").WirelessDeviceType;

/// Information about a wireless device's operation.
pub const WirelessDeviceStatistics = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// The name of the destination to which the device is assigned.
    destination_name: ?[]const u8 = null,

    fuota_device_status: ?FuotaDeviceStatus = null,

    /// The ID of the wireless device reporting the data.
    id: ?[]const u8 = null,

    /// The date and time when the most recent uplink was received.
    ///
    /// Theis value is only valid for 3 months.
    last_uplink_received_at: ?[]const u8 = null,

    /// LoRaWAN device info.
    lo_ra_wan: ?LoRaWANListDevice = null,

    mc_group_id: ?i32 = null,

    /// The status of the wireless device in the multicast group.
    multicast_device_status: ?[]const u8 = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// The integration status of the Device Location feature for LoRaWAN and Amazon
    /// Sidewalk enabled devices.
    positioning: ?PositioningConfigStatus = null,

    /// The Sidewalk account credentials.
    sidewalk: ?SidewalkListDevice = null,

    /// The wireless device type.
    @"type": ?WirelessDeviceType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .destination_name = "DestinationName",
        .fuota_device_status = "FuotaDeviceStatus",
        .id = "Id",
        .last_uplink_received_at = "LastUplinkReceivedAt",
        .lo_ra_wan = "LoRaWAN",
        .mc_group_id = "McGroupId",
        .multicast_device_status = "MulticastDeviceStatus",
        .name = "Name",
        .positioning = "Positioning",
        .sidewalk = "Sidewalk",
        .@"type" = "Type",
    };
};
