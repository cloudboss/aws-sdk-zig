const DashRoleAudio = @import("dash_role_audio.zig").DashRoleAudio;
const AudioNormalizationSettings = @import("audio_normalization_settings.zig").AudioNormalizationSettings;
const AudioType = @import("audio_type.zig").AudioType;
const AudioDescriptionAudioTypeControl = @import("audio_description_audio_type_control.zig").AudioDescriptionAudioTypeControl;
const AudioWatermarkSettings = @import("audio_watermark_settings.zig").AudioWatermarkSettings;
const AudioCodecSettings = @import("audio_codec_settings.zig").AudioCodecSettings;
const DvbDashAccessibility = @import("dvb_dash_accessibility.zig").DvbDashAccessibility;
const AudioDescriptionLanguageCodeControl = @import("audio_description_language_code_control.zig").AudioDescriptionLanguageCodeControl;
const RemixSettings = @import("remix_settings.zig").RemixSettings;

/// Audio Description
pub const AudioDescription = struct {
    /// Identifies the DASH roles to assign to this audio output. Applies only when
    /// the audio output is configured for DVB DASH accessibility signaling.
    audio_dash_roles: ?[]const DashRoleAudio,

    /// Advanced audio normalization settings.
    audio_normalization_settings: ?AudioNormalizationSettings,

    /// The name of the AudioSelector used as the source for this AudioDescription.
    audio_selector_name: []const u8,

    /// Applies only if audioTypeControl is useConfigured. The values for audioType
    /// are defined in ISO-IEC 13818-1.
    audio_type: ?AudioType,

    /// Determines how audio type is determined.
    /// followInput: If the input contains an ISO 639 audioType, then that value is
    /// passed through to the output. If the input contains no ISO 639 audioType,
    /// the value in Audio Type is included in the output.
    /// useConfigured: The value in Audio Type is included in the output.
    /// Note that this field and audioType are both ignored if inputType is
    /// broadcasterMixedAd.
    audio_type_control: ?AudioDescriptionAudioTypeControl,

    /// Settings to configure one or more solutions that insert audio watermarks in
    /// the audio encode
    audio_watermarking_settings: ?AudioWatermarkSettings,

    /// Audio codec settings.
    codec_settings: ?AudioCodecSettings,

    /// Identifies DVB DASH accessibility signaling in this audio output. Used in
    /// Microsoft Smooth Streaming outputs to signal accessibility information to
    /// packagers.
    dvb_dash_accessibility: ?DvbDashAccessibility,

    /// RFC 5646 language code representing the language of the audio output track.
    /// Only used if languageControlMode is useConfigured, or there is no ISO 639
    /// language code specified in the input.
    language_code: ?[]const u8,

    /// Choosing followInput will cause the ISO 639 language code of the output to
    /// follow the ISO 639 language code of the input. The languageCode will be used
    /// when useConfigured is set, or when followInput is selected but there is no
    /// ISO 639 language code specified by the input.
    language_code_control: ?AudioDescriptionLanguageCodeControl,

    /// The name of this AudioDescription. Outputs will use this name to uniquely
    /// identify this AudioDescription. Description names should be unique within
    /// this Live Event.
    name: []const u8,

    /// Settings that control how input audio channels are remixed into the output
    /// audio channels.
    remix_settings: ?RemixSettings,

    /// Used for MS Smooth and Apple HLS outputs. Indicates the name displayed by
    /// the player (eg. English, or Director Commentary).
    stream_name: ?[]const u8,

    pub const json_field_names = .{
        .audio_dash_roles = "AudioDashRoles",
        .audio_normalization_settings = "AudioNormalizationSettings",
        .audio_selector_name = "AudioSelectorName",
        .audio_type = "AudioType",
        .audio_type_control = "AudioTypeControl",
        .audio_watermarking_settings = "AudioWatermarkingSettings",
        .codec_settings = "CodecSettings",
        .dvb_dash_accessibility = "DvbDashAccessibility",
        .language_code = "LanguageCode",
        .language_code_control = "LanguageCodeControl",
        .name = "Name",
        .remix_settings = "RemixSettings",
        .stream_name = "StreamName",
    };
};
