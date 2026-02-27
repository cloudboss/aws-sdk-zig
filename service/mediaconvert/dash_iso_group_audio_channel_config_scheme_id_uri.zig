/// Use this setting only when your audio codec is a Dolby one (AC3, EAC3, or
/// Atmos) and your downstream workflow requires that your DASH manifest use the
/// Dolby channel configuration tag, rather than the MPEG one. For example, you
/// might need to use this to make dynamic ad insertion work. Specify which
/// audio channel configuration scheme ID URI MediaConvert writes in your DASH
/// manifest. Keep the default value, MPEG channel configuration, to have
/// MediaConvert write this: urn:mpeg:mpegB:cicp:ChannelConfiguration. Choose
/// Dolby channel configuration to have MediaConvert write this instead:
/// tag:dolby.com,2014:dash:audio_channel_configuration:2011.
pub const DashIsoGroupAudioChannelConfigSchemeIdUri = enum {
    mpeg_channel_configuration,
    dolby_channel_configuration,

    pub const json_field_names = .{
        .mpeg_channel_configuration = "MPEG_CHANNEL_CONFIGURATION",
        .dolby_channel_configuration = "DOLBY_CHANNEL_CONFIGURATION",
    };
};
