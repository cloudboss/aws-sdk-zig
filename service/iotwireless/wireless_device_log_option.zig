const WirelessDeviceEventLogOption = @import("wireless_device_event_log_option.zig").WirelessDeviceEventLogOption;
const LogLevel = @import("log_level.zig").LogLevel;
const WirelessDeviceType = @import("wireless_device_type.zig").WirelessDeviceType;

/// The log options for wireless devices and can be used to set log levels for a
/// specific
/// type of wireless device.
pub const WirelessDeviceLogOption = struct {
    events: ?[]const WirelessDeviceEventLogOption = null,

    log_level: LogLevel,

    /// The wireless device type.
    @"type": WirelessDeviceType,

    pub const json_field_names = .{
        .events = "Events",
        .log_level = "LogLevel",
        .@"type" = "Type",
    };
};
