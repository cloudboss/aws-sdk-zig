/// When set to FOLLOW_INPUT, if the input contains an ISO 639 audio_type, then
/// that value is passed through to the output. If the input contains no ISO 639
/// audio_type, the value in Audio Type is included in the output. Otherwise the
/// value in Audio Type is included in the output. Note that this field and
/// audioType are both ignored if audioDescriptionBroadcasterMix is set to
/// BROADCASTER_MIXED_AD.
pub const AudioTypeControl = enum {
    follow_input,
    use_configured,

    pub const json_field_names = .{
        .follow_input = "FOLLOW_INPUT",
        .use_configured = "USE_CONFIGURED",
    };
};
