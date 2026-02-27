const AudioDurationCorrection = @import("audio_duration_correction.zig").AudioDurationCorrection;
const LanguageCode = @import("language_code.zig").LanguageCode;
const DynamicAudioSelectorType = @import("dynamic_audio_selector_type.zig").DynamicAudioSelectorType;

/// Use Dynamic audio selectors when you do not know the track layout of your
/// source when you submit your job, but want to select multiple audio tracks.
/// When you include an audio track in your output and specify this Dynamic
/// audio selector as the Audio source, MediaConvert creates an audio track
/// within that output for each dynamically selected track. Note that when you
/// include a Dynamic audio selector for two or more inputs, each input must
/// have the same number of audio tracks and audio channels.
pub const DynamicAudioSelector = struct {
    /// Apply audio timing corrections to help synchronize audio and video in your
    /// output. To apply timing corrections, your input must meet the following
    /// requirements: * Container: MP4, or MOV, with an accurate time-to-sample
    /// (STTS) table. * Audio track: AAC. Choose from the following audio timing
    /// correction settings: * Disabled (Default): Apply no correction. * Auto:
    /// Recommended for most inputs. MediaConvert analyzes the audio timing in your
    /// input and determines which correction setting to use, if needed. * Track:
    /// Adjust the duration of each audio frame by a constant amount to align the
    /// audio track length with STTS duration. Track-level correction does not
    /// affect pitch, and is recommended for tonal audio content such as music. *
    /// Frame: Adjust the duration of each audio frame by a variable amount to align
    /// audio frames with STTS timestamps. No corrections are made to
    /// already-aligned frames. Frame-level correction may affect the pitch of
    /// corrected frames, and is recommended for atonal audio content such as speech
    /// or percussion. * Force: Apply audio duration correction, either Track or
    /// Frame depending on your input, regardless of the accuracy of your input's
    /// STTS table. Your output audio and video may not be aligned or it may contain
    /// audio artifacts.
    audio_duration_correction: ?AudioDurationCorrection,

    /// Specify the S3, HTTP, or HTTPS URL for your external audio file input.
    external_audio_file_input: ?[]const u8,

    /// Specify the language, using an ISO 639-2 three-letter code in all capital
    /// letters. You can find a list of codes at:
    /// https://www.loc.gov/standards/iso639-2/php/code_list.php
    language_code: ?LanguageCode,

    /// Specify a time delta, in milliseconds, to offset the audio from the input
    /// video.
    /// To specify no offset: Keep the default value, 0.
    /// To specify an offset: Enter an integer from -2147483648 to 2147483647
    offset: ?i32,

    /// Specify which audio tracks to dynamically select from your source. To select
    /// all audio tracks: Keep the default value, All tracks. To select all audio
    /// tracks with a specific language code: Choose Language code. When you do, you
    /// must also specify a language code under the Language code setting. If there
    /// is no matching Language code in your source, then no track will be selected.
    selector_type: ?DynamicAudioSelectorType,

    pub const json_field_names = .{
        .audio_duration_correction = "AudioDurationCorrection",
        .external_audio_file_input = "ExternalAudioFileInput",
        .language_code = "LanguageCode",
        .offset = "Offset",
        .selector_type = "SelectorType",
    };
};
