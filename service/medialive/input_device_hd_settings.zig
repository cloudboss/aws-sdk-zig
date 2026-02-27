const InputDeviceActiveInput = @import("input_device_active_input.zig").InputDeviceActiveInput;
const InputDeviceConfiguredInput = @import("input_device_configured_input.zig").InputDeviceConfiguredInput;
const InputDeviceState = @import("input_device_state.zig").InputDeviceState;
const InputDeviceScanType = @import("input_device_scan_type.zig").InputDeviceScanType;

/// Settings that describe the active source from the input device, and the
/// video characteristics of that source.
pub const InputDeviceHdSettings = struct {
    /// If you specified Auto as the configured input, specifies which of the
    /// sources is currently active (SDI or HDMI).
    active_input: ?InputDeviceActiveInput,

    /// The source at the input device that is currently active. You can specify
    /// this source.
    configured_input: ?InputDeviceConfiguredInput,

    /// The state of the input device.
    device_state: ?InputDeviceState,

    /// The frame rate of the video source.
    framerate: ?f64,

    /// The height of the video source, in pixels.
    height: ?i32,

    /// The Link device's buffer size (latency) in milliseconds (ms). You can
    /// specify this value.
    latency_ms: ?i32,

    /// The current maximum bitrate for ingesting this source, in bits per second.
    /// You can specify this maximum.
    max_bitrate: ?i32,

    /// The scan type of the video source.
    scan_type: ?InputDeviceScanType,

    /// The width of the video source, in pixels.
    width: ?i32,

    pub const json_field_names = .{
        .active_input = "ActiveInput",
        .configured_input = "ConfiguredInput",
        .device_state = "DeviceState",
        .framerate = "Framerate",
        .height = "Height",
        .latency_ms = "LatencyMs",
        .max_bitrate = "MaxBitrate",
        .scan_type = "ScanType",
        .width = "Width",
    };
};
