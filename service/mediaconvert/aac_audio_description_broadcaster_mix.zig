/// Choose BROADCASTER_MIXED_AD when the input contains pre-mixed main audio +
/// audio description (AD) as a stereo pair. The value for AudioType will be set
/// to 3, which signals to downstream systems that this stream contains
/// "broadcaster mixed AD". Note that the input received by the encoder must
/// contain pre-mixed audio; the encoder does not perform the mixing. When you
/// choose BROADCASTER_MIXED_AD, the encoder ignores any values you provide in
/// AudioType and FollowInputAudioType. Choose NORMAL when the input does not
/// contain pre-mixed audio + audio description (AD). In this case, the encoder
/// will use any values you provide for AudioType and FollowInputAudioType.
pub const AacAudioDescriptionBroadcasterMix = enum {
    broadcaster_mixed_ad,
    normal,

    pub const json_field_names = .{
        .broadcaster_mixed_ad = "BROADCASTER_MIXED_AD",
        .normal = "NORMAL",
    };
};
