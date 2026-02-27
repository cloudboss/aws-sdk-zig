const DownlinkMode = @import("downlink_mode.zig").DownlinkMode;
const GatewayListItem = @import("gateway_list_item.zig").GatewayListItem;

/// Specify the list of gateways to which you want to send downlink data traffic
/// when the
/// wireless device is running in class B or class C mode.
pub const ParticipatingGateways = struct {
    /// Indicates whether to send the downlink message in sequential mode or
    /// concurrent mode,
    /// or to use only the chosen gateways from the previous uplink message
    /// transmission.
    downlink_mode: DownlinkMode,

    /// The list of gateways that you want to use for sending the downlink data
    /// traffic.
    gateway_list: []const GatewayListItem,

    /// The duration of time for which AWS IoT Core for LoRaWAN will wait before
    /// transmitting
    /// the payload to the next gateway.
    transmission_interval: i32,

    pub const json_field_names = .{
        .downlink_mode = "DownlinkMode",
        .gateway_list = "GatewayList",
        .transmission_interval = "TransmissionInterval",
    };
};
