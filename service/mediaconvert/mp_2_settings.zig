const Mp2AudioDescriptionMix = @import("mp_2_audio_description_mix.zig").Mp2AudioDescriptionMix;

/// Required when you set Codec to the value MP2.
pub const Mp2Settings = struct {
    /// Choose BROADCASTER_MIXED_AD when the input contains pre-mixed main audio +
    /// audio description (AD) as a stereo pair. The value for AudioType will be set
    /// to 3, which signals to downstream systems that this stream contains
    /// "broadcaster mixed AD". Note that the input received by the encoder must
    /// contain pre-mixed audio; the encoder does not perform the mixing. When you
    /// choose BROADCASTER_MIXED_AD, the encoder ignores any values you provide in
    /// AudioType and FollowInputAudioType. Choose NONE when the input does not
    /// contain pre-mixed audio + audio description (AD). In this case, the encoder
    /// will use any values you provide for AudioType and FollowInputAudioType.
    audio_description_mix: ?Mp2AudioDescriptionMix,

    /// Specify the average bitrate in bits per second.
    bitrate: ?i32,

    /// Set Channels to specify the number of channels in this output audio track.
    /// Choosing Follow input will use the number of channels found in the audio
    /// source; choosing Mono will give you 1 output channel; choosing Stereo will
    /// give you 2. In the API, valid values are 0, 1, and 2.
    channels: ?i32,

    /// Sample rate in Hz.
    sample_rate: ?i32,

    pub const json_field_names = .{
        .audio_description_mix = "AudioDescriptionMix",
        .bitrate = "Bitrate",
        .channels = "Channels",
        .sample_rate = "SampleRate",
    };
};
