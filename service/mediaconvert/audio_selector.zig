const AudioDurationCorrection = @import("audio_duration_correction.zig").AudioDurationCorrection;
const AudioDefaultSelection = @import("audio_default_selection.zig").AudioDefaultSelection;
const HlsRenditionGroupSettings = @import("hls_rendition_group_settings.zig").HlsRenditionGroupSettings;
const LanguageCode = @import("language_code.zig").LanguageCode;
const RemixSettings = @import("remix_settings.zig").RemixSettings;
const AudioSelectorType = @import("audio_selector_type.zig").AudioSelectorType;

/// Use Audio selectors to specify a track or set of tracks from the input that
/// you will use in your outputs. You can use multiple Audio selectors per
/// input.
pub const AudioSelector = struct {
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

    /// Selects a specific language code from within an audio source, using the ISO
    /// 639-2 or ISO 639-3 three-letter language code
    custom_language_code: ?[]const u8,

    /// Specify a fallback audio selector for this input. Use to ensure outputs have
    /// audio even when the audio selector you specify in your output is missing
    /// from the source. DEFAULT (Checked in the MediaConvert console): If your
    /// output settings specify an audio selector that does not exist in this input,
    /// MediaConvert uses this audio selector instead. This is useful when you have
    /// multiple inputs with a different number of audio tracks. NOT_DEFAULT
    /// (Unchecked in the MediaConvert console): MediaConvert will not fallback from
    /// any missing audio selector. Any output specifying a missing audio selector
    /// will be silent.
    default_selection: ?AudioDefaultSelection,

    /// Specify the S3, HTTP, or HTTPS URL for your external audio file input.
    external_audio_file_input: ?[]const u8,

    /// Settings specific to audio sources in an HLS alternate rendition group.
    /// Specify the properties (renditionGroupId, renditionName or
    /// renditionLanguageCode) to identify the unique audio track among the
    /// alternative rendition groups present in the HLS manifest. If no unique track
    /// is found, or multiple tracks match the properties provided, the job fails.
    /// If no properties in hlsRenditionGroupSettings are specified, the default
    /// audio track within the video segment is chosen. If there is no audio within
    /// video segment, the alternative audio with DEFAULT=YES is chosen instead.
    hls_rendition_group_settings: ?HlsRenditionGroupSettings,

    /// Specify the language, using an ISO 639-2 three-letter code in all capital
    /// letters. You can find a list of codes at:
    /// https://www.loc.gov/standards/iso639-2/php/code_list.php
    language_code: ?LanguageCode,

    /// Specify a time delta, in milliseconds, to offset the audio from the input
    /// video.
    /// To specify no offset: Keep the default value, 0.
    /// To specify an offset: Enter an integer from -2147483648 to 2147483647
    offset: ?i32,

    /// Selects a specific PID from within an audio source (e.g. 257 selects PID
    /// 0x101).
    pids: ?[]const i32,

    /// Use this setting for input streams that contain Dolby E, to have the service
    /// extract specific program data from the track. To select multiple programs,
    /// create multiple selectors with the same Track and different Program numbers.
    /// In the console, this setting is visible when you set Selector type to Track.
    /// Choose the program number from the dropdown list. If your input file has
    /// incorrect metadata, you can choose All channels instead of a program number
    /// to have the service ignore the program IDs and include all the programs in
    /// the track.
    program_selection: ?i32,

    /// Use these settings to reorder the audio channels of one input to match those
    /// of another input. This allows you to combine the two files into a single
    /// output, one after the other.
    remix_settings: ?RemixSettings,

    /// Specify how MediaConvert selects audio content within your input. The
    /// default is Track. PID: Select audio by specifying the Packet Identifier
    /// (PID) values for MPEG Transport Stream inputs. Use this when you know the
    /// exact PID values of your audio streams. Track: Default. Select audio by
    /// track number. This is the most common option and works with most input
    /// container formats. If more types of audio data get recognized in the future,
    /// these numberings may shift, but the numberings used for Stream mode will
    /// not. Language code: Select audio by language using an ISO 639-2 or ISO 639-3
    /// three-letter code in all capital letters. Use this when your source has
    /// embedded language metadata and you want to select tracks based on their
    /// language. HLS rendition group: Select audio from an HLS rendition group. Use
    /// this when your input is an HLS package with multiple audio renditions and
    /// you want to select specific rendition groups. All PCM: Select all
    /// uncompressed PCM audio tracks from your input automatically. This is useful
    /// when you want to include all PCM audio tracks without specifying individual
    /// track numbers. Stream: Select audio by stream number. Stream numbers include
    /// all tracks in the source file, regardless of type, and correspond to either
    /// the order of tracks in the file, or if applicable, the stream number
    /// metadata of the track. Although all tracks count toward these stream
    /// numbers, in this audio selector context, only the stream number of a track
    /// containing audio data may be used. If your source file contains a track
    /// which is not recognized by the service, then the corresponding stream number
    /// will still be reserved for future use. If more types of audio data get
    /// recognized in the future, these numberings will not shift.
    selector_type: ?AudioSelectorType,

    /// Identify a track from the input audio to include in this selector by
    /// entering the stream index number. These numberings count all tracks in the
    /// input file, but only a track containing audio data may be used here. To
    /// include several tracks in a single audio selector, specify multiple tracks
    /// as follows. Using the console, enter a comma-separated list. For example,
    /// type "1,2,3" to include tracks 1 through 3.
    streams: ?[]const i32,

    /// Identify a track from the input audio to include in this selector by
    /// entering the track index number. These numberings include only tracks
    /// recognized as audio. If the service recognizes more types of audio tracks in
    /// the future, these numberings may shift. To include several tracks in a
    /// single audio selector, specify multiple tracks as follows. Using the
    /// console, enter a comma-separated list. For example, type "1,2,3" to include
    /// tracks 1 through 3.
    tracks: ?[]const i32,

    pub const json_field_names = .{
        .audio_duration_correction = "AudioDurationCorrection",
        .custom_language_code = "CustomLanguageCode",
        .default_selection = "DefaultSelection",
        .external_audio_file_input = "ExternalAudioFileInput",
        .hls_rendition_group_settings = "HlsRenditionGroupSettings",
        .language_code = "LanguageCode",
        .offset = "Offset",
        .pids = "Pids",
        .program_selection = "ProgramSelection",
        .remix_settings = "RemixSettings",
        .selector_type = "SelectorType",
        .streams = "Streams",
        .tracks = "Tracks",
    };
};
