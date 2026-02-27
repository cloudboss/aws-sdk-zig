/// Gateway list item object that specifies the frequency and list of gateways
/// for which
/// the downlink message should be sent.
pub const GatewayListItem = struct {
    /// The frequency to use for the gateways when sending a downlink message to the
    /// wireless
    /// device.
    downlink_frequency: i32,

    /// The ID of the wireless gateways that you want to add to the list of gateways
    /// when
    /// sending downlink messages.
    gateway_id: []const u8,

    pub const json_field_names = .{
        .downlink_frequency = "DownlinkFrequency",
        .gateway_id = "GatewayId",
    };
};
