/// `FrameInfo` of your wireless device resources for the trace content. Use
/// FrameInfo to debug the communication between your LoRaWAN end devices and
/// the network
/// server.
pub const WirelessDeviceFrameInfo = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
