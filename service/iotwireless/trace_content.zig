const LogLevel = @import("log_level.zig").LogLevel;
const MulticastFrameInfo = @import("multicast_frame_info.zig").MulticastFrameInfo;
const WirelessDeviceFrameInfo = @import("wireless_device_frame_info.zig").WirelessDeviceFrameInfo;

/// Trace content for your wireless devices, gateways, and multicast groups.
pub const TraceContent = struct {
    log_level: ?LogLevel = null,

    multicast_frame_info: ?MulticastFrameInfo = null,

    wireless_device_frame_info: ?WirelessDeviceFrameInfo = null,

    pub const json_field_names = .{
        .log_level = "LogLevel",
        .multicast_frame_info = "MulticastFrameInfo",
        .wireless_device_frame_info = "WirelessDeviceFrameInfo",
    };
};
