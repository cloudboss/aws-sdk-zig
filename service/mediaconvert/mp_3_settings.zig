const Mp3RateControlMode = @import("mp_3_rate_control_mode.zig").Mp3RateControlMode;

/// Required when you set Codec, under AudioDescriptions>CodecSettings, to the
/// value MP3.
pub const Mp3Settings = struct {
    /// Specify the average bitrate in bits per second.
    bitrate: ?i32,

    /// Specify the number of channels in this output audio track. Choosing Follow
    /// input will use the number of channels found in the audio source; choosing
    /// Mono gives you 1 output channel; choosing Stereo gives you 2. In the API,
    /// valid values are 0, 1, and 2.
    channels: ?i32,

    /// Specify whether the service encodes this MP3 audio output with a constant
    /// bitrate (CBR) or a variable bitrate (VBR).
    rate_control_mode: ?Mp3RateControlMode,

    /// Sample rate in Hz.
    sample_rate: ?i32,

    /// Required when you set Bitrate control mode to VBR. Specify the audio quality
    /// of this MP3 output from 0 (highest quality) to 9 (lowest quality).
    vbr_quality: ?i32,

    pub const json_field_names = .{
        .bitrate = "Bitrate",
        .channels = "Channels",
        .rate_control_mode = "RateControlMode",
        .sample_rate = "SampleRate",
        .vbr_quality = "VbrQuality",
    };
};
