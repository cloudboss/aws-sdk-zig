const InputDeviceActiveInput = @import("input_device_active_input.zig").InputDeviceActiveInput;
const InputDeviceUhdAudioChannelPairConfig = @import("input_device_uhd_audio_channel_pair_config.zig").InputDeviceUhdAudioChannelPairConfig;
const InputDeviceCodec = @import("input_device_codec.zig").InputDeviceCodec;
const InputDeviceConfiguredInput = @import("input_device_configured_input.zig").InputDeviceConfiguredInput;
const InputDeviceState = @import("input_device_state.zig").InputDeviceState;
const InputDeviceMediaConnectSettings = @import("input_device_media_connect_settings.zig").InputDeviceMediaConnectSettings;
const InputDeviceScanType = @import("input_device_scan_type.zig").InputDeviceScanType;

/// Settings that describe the active source from the input device, and the
/// video characteristics of that source.
pub const InputDeviceUhdSettings = struct {
    /// If you specified Auto as the configured input, specifies which of the
    /// sources is currently active (SDI or HDMI).
    active_input: ?InputDeviceActiveInput,

    /// An array of eight audio configurations, one for each audio pair in the
    /// source. Each audio configuration specifies either to exclude the pair, or to
    /// format it and include it in the output from the UHD device. Applies only
    /// when the device is configured as the source for a MediaConnect flow.
    audio_channel_pairs: ?[]const InputDeviceUhdAudioChannelPairConfig,

    /// The codec for the video that the device produces.
    codec: ?InputDeviceCodec,

    /// The source at the input device that is currently active. You can specify
    /// this source.
    configured_input: ?InputDeviceConfiguredInput,

    /// The state of the input device.
    device_state: ?InputDeviceState,

    /// The frame rate of the video source.
    framerate: ?f64,

    /// The height of the video source, in pixels.
    height: ?i32,

    /// The resolution of the Link device's source (HD or UHD). This value
    /// determines MediaLive resource allocation and billing for this input.
    input_resolution: ?[]const u8,

    /// The Link device's buffer size (latency) in milliseconds (ms). You can
    /// specify this value.
    latency_ms: ?i32,

    /// The current maximum bitrate for ingesting this source, in bits per second.
    /// You can specify this maximum.
    max_bitrate: ?i32,

    /// Information about the MediaConnect flow attached to the device. Returned
    /// only if the outputType is MEDIACONNECT_FLOW.
    mediaconnect_settings: ?InputDeviceMediaConnectSettings,

    /// The scan type of the video source.
    scan_type: ?InputDeviceScanType,

    /// The width of the video source, in pixels.
    width: ?i32,

    pub const json_field_names = .{
        .active_input = "ActiveInput",
        .audio_channel_pairs = "AudioChannelPairs",
        .codec = "Codec",
        .configured_input = "ConfiguredInput",
        .device_state = "DeviceState",
        .framerate = "Framerate",
        .height = "Height",
        .input_resolution = "InputResolution",
        .latency_ms = "LatencyMs",
        .max_bitrate = "MaxBitrate",
        .mediaconnect_settings = "MediaconnectSettings",
        .scan_type = "ScanType",
        .width = "Width",
    };
};
