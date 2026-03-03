const LoRaWANGateway = @import("lo_ra_wan_gateway.zig").LoRaWANGateway;

/// Information about a wireless gateway's operation.
pub const WirelessGatewayStatistics = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// The description of the resource.
    description: ?[]const u8 = null,

    /// The ID of the wireless gateway reporting the data.
    id: ?[]const u8 = null,

    /// The date and time when the most recent uplink was received.
    ///
    /// This value is only valid for 3 months.
    last_uplink_received_at: ?[]const u8 = null,

    /// LoRaWAN gateway info.
    lo_ra_wan: ?LoRaWANGateway = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .last_uplink_received_at = "LastUplinkReceivedAt",
        .lo_ra_wan = "LoRaWAN",
        .name = "Name",
    };
};
