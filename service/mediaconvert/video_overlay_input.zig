const aws = @import("aws");

const AudioSelector = @import("audio_selector.zig").AudioSelector;
const VideoOverlayInputClipping = @import("video_overlay_input_clipping.zig").VideoOverlayInputClipping;
const InputTimecodeSource = @import("input_timecode_source.zig").InputTimecodeSource;

/// Input settings for Video overlay. You can include one or more video overlays
/// in sequence at different times that you specify.
pub const VideoOverlayInput = struct {
    /// Use Audio selectors to specify audio to use during your Video overlay. You
    /// can use multiple Audio selectors per Video overlay. When you include an
    /// Audio selector within a Video overlay, MediaConvert mutes any Audio
    /// selectors with the same name from the underlying input. For example, if your
    /// underlying input has Audio selector 1 and Audio selector 2, and your Video
    /// overlay only has Audio selector 1, then MediaConvert replaces all audio for
    /// Audio selector 1 during the Video overlay. To replace all audio for all
    /// Audio selectors from the underlying input by using a single Audio selector
    /// in your overlay, set DefaultSelection to DEFAULT (Check \"Use as default\"
    /// in the MediaConvert console).
    audio_selectors: ?[]const aws.map.MapEntry(AudioSelector) = null,

    /// Specify the input file S3, HTTP, or HTTPS URL for your video overlay.
    /// To specify one or more Transitions for your base input video instead: Leave
    /// blank.
    file_input: ?[]const u8 = null,

    /// Specify one or more clips to use from your video overlay. When you include
    /// an input clip, you must also specify its start timecode, end timecode, or
    /// both start and end timecode.
    input_clippings: ?[]const VideoOverlayInputClipping = null,

    /// Specify the timecode source for your video overlay input clips. To use the
    /// timecode present in your video overlay: Choose Embedded. To use a zerobased
    /// timecode: Choose Start at 0. To choose a timecode: Choose Specified start.
    /// When you do, enter the starting timecode in Start timecode. If you don't
    /// specify a value for Timecode source, MediaConvert uses Embedded by default.
    timecode_source: ?InputTimecodeSource = null,

    /// Specify the starting timecode for this video overlay. To use this setting,
    /// you must set Timecode source to Specified start.
    timecode_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_selectors = "AudioSelectors",
        .file_input = "FileInput",
        .input_clippings = "InputClippings",
        .timecode_source = "TimecodeSource",
        .timecode_start = "TimecodeStart",
    };
};
