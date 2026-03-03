const AudioSelector = @import("audio_selector.zig").AudioSelector;
const CaptionSelector = @import("caption_selector.zig").CaptionSelector;
const InputDeblockFilter = @import("input_deblock_filter.zig").InputDeblockFilter;
const InputDenoiseFilter = @import("input_denoise_filter.zig").InputDenoiseFilter;
const InputFilter = @import("input_filter.zig").InputFilter;
const NetworkInputSettings = @import("network_input_settings.zig").NetworkInputSettings;
const Smpte2038DataPreference = @import("smpte_2038_data_preference.zig").Smpte2038DataPreference;
const InputSourceEndBehavior = @import("input_source_end_behavior.zig").InputSourceEndBehavior;
const VideoSelector = @import("video_selector.zig").VideoSelector;

/// Live Event input parameters. There can be multiple inputs in a single Live
/// Event.
pub const InputSettings = struct {
    /// Used to select the audio stream to decode for inputs that have multiple
    /// available.
    audio_selectors: ?[]const AudioSelector = null,

    /// Used to select the caption input to use for inputs that have multiple
    /// available.
    caption_selectors: ?[]const CaptionSelector = null,

    /// Enable or disable the deblock filter when filtering.
    deblock_filter: ?InputDeblockFilter = null,

    /// Enable or disable the denoise filter when filtering.
    denoise_filter: ?InputDenoiseFilter = null,

    /// Adjusts the magnitude of filtering from 1 (minimal) to 5 (strongest).
    filter_strength: ?i32 = null,

    /// Turns on the filter for this input. MPEG-2 inputs have the deblocking filter
    /// enabled by default.
    /// 1) auto - filtering will be applied depending on input type/quality
    /// 2) disabled - no filtering will be applied to the input
    /// 3) forced - filtering will be applied regardless of input type
    input_filter: ?InputFilter = null,

    /// Input settings.
    network_input_settings: ?NetworkInputSettings = null,

    /// PID from which to read SCTE-35 messages. If left undefined, EML will select
    /// the first SCTE-35 PID found in the input.
    scte_35_pid: ?i32 = null,

    /// Specifies whether to extract applicable ancillary data from a SMPTE-2038
    /// source in this input. Applicable data types are captions, timecode, AFD, and
    /// SCTE-104 messages.
    /// - PREFER: Extract from SMPTE-2038 if present in this input, otherwise
    /// extract from another source (if any).
    /// - IGNORE: Never extract any ancillary data from SMPTE-2038.
    smpte_2038_data_preference: ?Smpte2038DataPreference = null,

    /// Loop input if it is a file. This allows a file input to be streamed
    /// indefinitely.
    source_end_behavior: ?InputSourceEndBehavior = null,

    /// Informs which video elementary stream to decode for input types that have
    /// multiple available.
    video_selector: ?VideoSelector = null,

    pub const json_field_names = .{
        .audio_selectors = "AudioSelectors",
        .caption_selectors = "CaptionSelectors",
        .deblock_filter = "DeblockFilter",
        .denoise_filter = "DenoiseFilter",
        .filter_strength = "FilterStrength",
        .input_filter = "InputFilter",
        .network_input_settings = "NetworkInputSettings",
        .scte_35_pid = "Scte35Pid",
        .smpte_2038_data_preference = "Smpte2038DataPreference",
        .source_end_behavior = "SourceEndBehavior",
        .video_selector = "VideoSelector",
    };
};
