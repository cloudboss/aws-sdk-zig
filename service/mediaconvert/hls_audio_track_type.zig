/// Four types of audio-only tracks are supported: Audio-Only Variant Stream The
/// client can play back this audio-only stream instead of video in
/// low-bandwidth scenarios. Represented as an EXT-X-STREAM-INF in the HLS
/// manifest. Alternate Audio, Auto Select, Default Alternate rendition that the
/// client should try to play back by default. Represented as an EXT-X-MEDIA in
/// the HLS manifest with DEFAULT=YES, AUTOSELECT=YES Alternate Audio, Auto
/// Select, Not Default Alternate rendition that the client may try to play back
/// by default. Represented as an EXT-X-MEDIA in the HLS manifest with
/// DEFAULT=NO, AUTOSELECT=YES Alternate Audio, not Auto Select Alternate
/// rendition that the client will not try to play back by default. Represented
/// as an EXT-X-MEDIA in the HLS manifest with DEFAULT=NO, AUTOSELECT=NO
pub const HlsAudioTrackType = enum {
    alternate_audio_auto_select_default,
    alternate_audio_auto_select,
    alternate_audio_not_auto_select,
    audio_only_variant_stream,

    pub const json_field_names = .{
        .alternate_audio_auto_select_default = "ALTERNATE_AUDIO_AUTO_SELECT_DEFAULT",
        .alternate_audio_auto_select = "ALTERNATE_AUDIO_AUTO_SELECT",
        .alternate_audio_not_auto_select = "ALTERNATE_AUDIO_NOT_AUTO_SELECT",
        .audio_only_variant_stream = "AUDIO_ONLY_VARIANT_STREAM",
    };
};
