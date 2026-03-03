const AudioChannelTaggingSettings = @import("audio_channel_tagging_settings.zig").AudioChannelTaggingSettings;
const AudioNormalizationSettings = @import("audio_normalization_settings.zig").AudioNormalizationSettings;
const AudioPitchCorrectionSettings = @import("audio_pitch_correction_settings.zig").AudioPitchCorrectionSettings;
const AudioTypeControl = @import("audio_type_control.zig").AudioTypeControl;
const AudioCodecSettings = @import("audio_codec_settings.zig").AudioCodecSettings;
const LanguageCode = @import("language_code.zig").LanguageCode;
const AudioLanguageCodeControl = @import("audio_language_code_control.zig").AudioLanguageCodeControl;
const RemixSettings = @import("remix_settings.zig").RemixSettings;

/// Settings related to one audio tab on the MediaConvert console. In your job
/// JSON, an instance of AudioDescription is equivalent to one audio tab in the
/// console. Usually, one audio tab corresponds to one output audio track.
/// Depending on how you set up your input audio selectors and whether you use
/// audio selector groups, one audio tab can correspond to a group of output
/// audio tracks.
pub const AudioDescription = struct {
    /// Specify the QuickTime audio channel layout tags for the audio channels in
    /// this audio track. When you don't specify a value, MediaConvert labels your
    /// track as Center (C) by default. To use Audio layout tagging, your output
    /// must be in a QuickTime (MOV) container and your audio codec must be AAC,
    /// WAV, or AIFF.
    audio_channel_tagging_settings: ?AudioChannelTaggingSettings = null,

    /// Advanced audio normalization settings. Ignore these settings unless you need
    /// to comply with a loudness standard.
    audio_normalization_settings: ?AudioNormalizationSettings = null,

    /// Settings for audio pitch correction during framerate conversion.
    audio_pitch_correction_settings: ?AudioPitchCorrectionSettings = null,

    /// Specifies which audio data to use from each input. In the simplest case,
    /// specify an "Audio Selector":#inputs-audio_selector by name based on its
    /// order within each input. For example if you specify "Audio Selector 3", then
    /// the third audio selector will be used from each input. If an input does not
    /// have an "Audio Selector 3", then the audio selector marked as "default" in
    /// that input will be used. If there is no audio selector marked as "default",
    /// silence will be inserted for the duration of that input. Alternatively, an
    /// "Audio Selector Group":#inputs-audio_selector_group name may be specified,
    /// with similar default/silence behavior. If no audio_source_name is specified,
    /// then "Audio Selector 1" will be chosen automatically.
    audio_source_name: ?[]const u8 = null,

    /// Applies only if Follow Input Audio Type is unchecked (false). A number
    /// between 0 and 255. The following are defined in ISO-IEC 13818-1: 0 =
    /// Undefined, 1 = Clean Effects, 2 = Hearing Impaired, 3 = Visually Impaired
    /// Commentary, 4-255 = Reserved.
    audio_type: ?i32 = null,

    /// When set to FOLLOW_INPUT, if the input contains an ISO 639 audio_type, then
    /// that value is passed through to the output. If the input contains no ISO 639
    /// audio_type, the value in Audio Type is included in the output. Otherwise the
    /// value in Audio Type is included in the output. Note that this field and
    /// audioType are both ignored if audioDescriptionBroadcasterMix is set to
    /// BROADCASTER_MIXED_AD.
    audio_type_control: ?AudioTypeControl = null,

    /// Settings related to audio encoding. The settings in this group vary
    /// depending on the value that you choose for your audio codec.
    codec_settings: ?AudioCodecSettings = null,

    /// Specify the language for this audio output track. The service puts this
    /// language code into your output audio track when you set Language code
    /// control to Use configured. The service also uses your specified custom
    /// language code when you set Language code control to Follow input, but your
    /// input file doesn't specify a language code. For all outputs, you can use an
    /// ISO 639-2 or ISO 639-3 code. For streaming outputs, you can also use any
    /// other code in the full RFC-5646 specification. Streaming outputs are those
    /// that are in one of the following output groups: CMAF, DASH ISO, Apple HLS,
    /// or Microsoft Smooth Streaming.
    custom_language_code: ?[]const u8 = null,

    /// Specify the language for your output audio track. To follow the input
    /// language: Leave blank. When you do, also set Language code control to Follow
    /// input. If no input language is detected MediaConvert will not write an
    /// output language code. To follow the input langauge, but fall back to a
    /// specified language code if there is no input language to follow: Enter an
    /// ISO 639-2 three-letter language code in all capital letters. When you do,
    /// also set Language code control to Follow input. To specify the language
    /// code: Enter an ISO 639 three-letter language code in all capital letters.
    /// When you do, also set Language code control to Use configured.
    language_code: ?LanguageCode = null,

    /// Specify which source for language code takes precedence for this audio
    /// track. When you choose Follow input, the service uses the language code from
    /// the input track if it's present. If there's no languge code on the input
    /// track, the service uses the code that you specify in the setting Language
    /// code. When you choose Use configured, the service uses the language code
    /// that you specify.
    language_code_control: ?AudioLanguageCodeControl = null,

    /// Advanced audio remixing settings.
    remix_settings: ?RemixSettings = null,

    /// Specify a label for this output audio stream. For example, "English",
    /// "Director commentary", or "track_2". For streaming outputs, MediaConvert
    /// passes this information into destination manifests for display on the
    /// end-viewer's player device. For outputs in other output groups, the service
    /// ignores this setting.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_channel_tagging_settings = "AudioChannelTaggingSettings",
        .audio_normalization_settings = "AudioNormalizationSettings",
        .audio_pitch_correction_settings = "AudioPitchCorrectionSettings",
        .audio_source_name = "AudioSourceName",
        .audio_type = "AudioType",
        .audio_type_control = "AudioTypeControl",
        .codec_settings = "CodecSettings",
        .custom_language_code = "CustomLanguageCode",
        .language_code = "LanguageCode",
        .language_code_control = "LanguageCodeControl",
        .remix_settings = "RemixSettings",
        .stream_name = "StreamName",
    };
};
