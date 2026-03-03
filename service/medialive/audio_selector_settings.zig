const AudioHlsRenditionSelection = @import("audio_hls_rendition_selection.zig").AudioHlsRenditionSelection;
const AudioLanguageSelection = @import("audio_language_selection.zig").AudioLanguageSelection;
const AudioPidSelection = @import("audio_pid_selection.zig").AudioPidSelection;
const AudioTrackSelection = @import("audio_track_selection.zig").AudioTrackSelection;

/// Audio Selector Settings
pub const AudioSelectorSettings = struct {
    audio_hls_rendition_selection: ?AudioHlsRenditionSelection = null,

    audio_language_selection: ?AudioLanguageSelection = null,

    audio_pid_selection: ?AudioPidSelection = null,

    audio_track_selection: ?AudioTrackSelection = null,

    pub const json_field_names = .{
        .audio_hls_rendition_selection = "AudioHlsRenditionSelection",
        .audio_language_selection = "AudioLanguageSelection",
        .audio_pid_selection = "AudioPidSelection",
        .audio_track_selection = "AudioTrackSelection",
    };
};
