/// Required when you set Codec, under AudioDescriptions>CodecSettings, to the
/// value OPUS.
pub const OpusSettings = struct {
    /// Optional. Specify the average bitrate in bits per second. Valid values are
    /// multiples of 8000, from 32000 through 192000. The default value is 96000,
    /// which we recommend for quality and bandwidth.
    bitrate: ?i32,

    /// Specify the number of channels in this output audio track. Choosing Follow
    /// input will use the number of channels found in the audio source; choosing
    /// Mono gives you 1 output channel; choosing Stereo gives you 2. In the API,
    /// valid values are 0, 1, and 2.
    channels: ?i32,

    /// Optional. Sample rate in Hz. Valid values are 16000, 24000, and 48000. The
    /// default value is 48000.
    sample_rate: ?i32,

    pub const json_field_names = .{
        .bitrate = "Bitrate",
        .channels = "Channels",
        .sample_rate = "SampleRate",
    };
};
