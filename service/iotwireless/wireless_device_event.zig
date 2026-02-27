/// The event for a log message, if the log message is tied to a wireless
/// device.
pub const WirelessDeviceEvent = enum {
    join,
    rejoin,
    uplink_data,
    downlink_data,
    registration,

    pub const json_field_names = .{
        .join = "Join",
        .rejoin = "Rejoin",
        .uplink_data = "Uplink_Data",
        .downlink_data = "Downlink_Data",
        .registration = "Registration",
    };
};
