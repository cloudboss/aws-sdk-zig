const ChannelMapping = @import("channel_mapping.zig").ChannelMapping;

/// Use Manual audio remixing to adjust audio levels for each audio channel in
/// each output of your job. With audio remixing, you can output more or fewer
/// audio channels than your input audio source provides.
pub const RemixSettings = struct {
    /// Optionally specify the channel in your input that contains your audio
    /// description audio signal. MediaConvert mixes your audio signal across all
    /// output channels, while reducing their volume according to your data stream.
    /// When you specify an audio description audio channel, you must also specify
    /// an audio description data channel. For more information about audio
    /// description signals, see the BBC WHP 198 and 051 white papers.
    audio_description_audio_channel: ?i32,

    /// Optionally specify the channel in your input that contains your audio
    /// description data stream. MediaConvert mixes your audio signal across all
    /// output channels, while reducing their volume according to your data stream.
    /// When you specify an audio description data channel, you must also specify an
    /// audio description audio channel. For more information about audio
    /// description signals, see the BBC WHP 198 and 051 white papers.
    audio_description_data_channel: ?i32,

    /// Channel mapping contains the group of fields that hold the remixing value
    /// for each channel, in dB. Specify remix values to indicate how much of the
    /// content from your input audio channel you want in your output audio
    /// channels. Each instance of the InputChannels or InputChannelsFineTune array
    /// specifies these values for one output channel. Use one instance of this
    /// array for each output channel. In the console, each array corresponds to a
    /// column in the graphical depiction of the mapping matrix. The rows of the
    /// graphical matrix correspond to input channels. Valid values are within the
    /// range from -60 (mute) through 6. A setting of 0 passes the input channel
    /// unchanged to the output channel (no attenuation or amplification). Use
    /// InputChannels or InputChannelsFineTune to specify your remix values. Don't
    /// use both.
    channel_mapping: ?ChannelMapping,

    /// Specify the number of audio channels from your input that you want to use in
    /// your output. With remixing, you might combine or split the data in these
    /// channels, so the number of channels in your final output might be different.
    /// If you are doing both input channel mapping and output channel mapping, the
    /// number of output channels in your input mapping must be the same as the
    /// number of input channels in your output mapping.
    channels_in: ?i32,

    /// Specify the number of channels in this output after remixing. Valid values:
    /// 1, 2, 4, 6, 8... 64. (1 and even numbers to 64.) If you are doing both input
    /// channel mapping and output channel mapping, the number of output channels in
    /// your input mapping must be the same as the number of input channels in your
    /// output mapping.
    channels_out: ?i32,

    pub const json_field_names = .{
        .audio_description_audio_channel = "AudioDescriptionAudioChannel",
        .audio_description_data_channel = "AudioDescriptionDataChannel",
        .channel_mapping = "ChannelMapping",
        .channels_in = "ChannelsIn",
        .channels_out = "ChannelsOut",
    };
};
