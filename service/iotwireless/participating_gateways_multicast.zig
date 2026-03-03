/// Specify the list of gateways to which you want to send the multicast
/// downlink
/// messages. The multicast message will be sent to each gateway in the list,
/// with the
/// transmission interval as the time interval between each message.
pub const ParticipatingGatewaysMulticast = struct {
    /// The list of gateways that you want to use for sending the multicast downlink
    /// message.
    /// Each downlink message will be sent to all the gateways in the list in the
    /// order that you
    /// provided. If the gateway list is empty, then AWS IoT Core for LoRaWAN
    /// chooses the
    /// gateways that were most recently used by the devices to send an uplink
    /// message.
    gateway_list: ?[]const []const u8 = null,

    /// The duration of time in milliseconds for which AWS IoT Core for LoRaWAN will
    /// wait
    /// before transmitting the multicast payload to the next gateway in the list.
    transmission_interval: ?i32 = null,

    pub const json_field_names = .{
        .gateway_list = "GatewayList",
        .transmission_interval = "TransmissionInterval",
    };
};
