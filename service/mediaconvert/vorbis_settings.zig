/// Required when you set Codec, under AudioDescriptions>CodecSettings, to the
/// value Vorbis.
pub const VorbisSettings = struct {
    /// Optional. Specify the number of channels in this output audio track.
    /// Choosing Follow input will use the number of channels found in the audio
    /// source; choosing Mono on the console gives you 1 output channel; choosing
    /// Stereo gives you 2. In the API, valid values are 0, 1, and 2. The default
    /// value is 2.
    channels: ?i32 = null,

    /// Optional. Specify the audio sample rate in Hz. Valid values are 22050,
    /// 32000, 44100, and 48000. The default value is 48000.
    sample_rate: ?i32 = null,

    /// Optional. Specify the variable audio quality of this Vorbis output from -1
    /// (lowest quality, ~45 kbit/s) to 10 (highest quality, ~500 kbit/s). The
    /// default value is 4 (~128 kbit/s). Values 5 and 6 are approximately 160 and
    /// 192 kbit/s, respectively.
    vbr_quality: ?i32 = null,

    pub const json_field_names = .{
        .channels = "Channels",
        .sample_rate = "SampleRate",
        .vbr_quality = "VbrQuality",
    };
};
