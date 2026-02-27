const InputDeviceConfigurableAudioChannelPairConfig = @import("input_device_configurable_audio_channel_pair_config.zig").InputDeviceConfigurableAudioChannelPairConfig;
const InputDeviceCodec = @import("input_device_codec.zig").InputDeviceCodec;
const InputDeviceConfiguredInput = @import("input_device_configured_input.zig").InputDeviceConfiguredInput;
const InputDeviceMediaConnectConfigurableSettings = @import("input_device_media_connect_configurable_settings.zig").InputDeviceMediaConnectConfigurableSettings;

/// Configurable settings for the input device.
pub const InputDeviceConfigurableSettings = struct {
    /// An array of eight audio configurations, one for each audio pair in the
    /// source. Set up each audio configuration either to exclude the pair, or to
    /// format it and include it in the output from the device. This parameter
    /// applies only to UHD devices, and only when the device is configured as the
    /// source for a MediaConnect flow. For an HD device, you configure the audio by
    /// setting up audio selectors in the channel configuration.
    audio_channel_pairs: ?[]const InputDeviceConfigurableAudioChannelPairConfig,

    /// Choose the codec for the video that the device produces. Only UHD devices
    /// can specify this parameter.
    codec: ?InputDeviceCodec,

    /// The input source that you want to use. If the device has a source connected
    /// to only one of its input ports, or if you don't care which source the device
    /// sends, specify Auto. If the device has sources connected to both its input
    /// ports, and you want to use a specific source, specify the source.
    configured_input: ?InputDeviceConfiguredInput,

    /// Choose the resolution of the Link device's source (HD or UHD). Make sure the
    /// resolution matches the current source from the device. This value determines
    /// MediaLive resource allocation and billing for this input. Only UHD devices
    /// can specify this parameter.
    input_resolution: ?[]const u8,

    /// The Link device's buffer size (latency) in milliseconds (ms).
    latency_ms: ?i32,

    /// The maximum bitrate in bits per second. Set a value here to throttle the
    /// bitrate of the source video.
    max_bitrate: ?i32,

    /// To attach this device to a MediaConnect flow, specify these parameters. To
    /// detach an existing flow, enter {} for the value of mediaconnectSettings.
    /// Only UHD devices can specify this parameter.
    mediaconnect_settings: ?InputDeviceMediaConnectConfigurableSettings,

    pub const json_field_names = .{
        .audio_channel_pairs = "AudioChannelPairs",
        .codec = "Codec",
        .configured_input = "ConfiguredInput",
        .input_resolution = "InputResolution",
        .latency_ms = "LatencyMs",
        .max_bitrate = "MaxBitrate",
        .mediaconnect_settings = "MediaconnectSettings",
    };
};
