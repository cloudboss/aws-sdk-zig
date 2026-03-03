const LoRaWANSendDataToDevice = @import("lo_ra_wan_send_data_to_device.zig").LoRaWANSendDataToDevice;

/// The message in the downlink queue.
pub const DownlinkQueueMessage = struct {
    lo_ra_wan: ?LoRaWANSendDataToDevice = null,

    /// The message ID assigned by IoT Wireless to each downlink message, which
    /// helps
    /// identify the message.
    message_id: ?[]const u8 = null,

    /// The time at which Iot Wireless received the downlink message.
    received_at: ?[]const u8 = null,

    /// The transmit mode to use for sending data to the wireless device. This can
    /// be
    /// `0` for UM (unacknowledge mode) or `1` for AM (acknowledge
    /// mode).
    transmit_mode: ?i32 = null,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
        .message_id = "MessageId",
        .received_at = "ReceivedAt",
        .transmit_mode = "TransmitMode",
    };
};
