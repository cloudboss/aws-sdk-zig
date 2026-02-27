const WirelessDeviceEvent = @import("wireless_device_event.zig").WirelessDeviceEvent;
const LogLevel = @import("log_level.zig").LogLevel;

/// The log options for a wireless device event and can be used to set log
/// levels for a
/// specific wireless device event.
///
/// For a LoRaWAN device, possible events for a log messsage are: `Join`,
/// `Rejoin`, `Downlink_Data`, and `Uplink_Data`. For a
/// Sidewalk device, possible events for a log message are `Registration`,
/// `Downlink_Data`, and `Uplink_Data`.
pub const WirelessDeviceEventLogOption = struct {
    event: WirelessDeviceEvent,

    log_level: LogLevel,

    pub const json_field_names = .{
        .event = "Event",
        .log_level = "LogLevel",
    };
};
