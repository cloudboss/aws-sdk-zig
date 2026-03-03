const IvrRecordingTrack = @import("ivr_recording_track.zig").IvrRecordingTrack;
const VoiceRecordingTrack = @import("voice_recording_track.zig").VoiceRecordingTrack;

/// Contains information about the recording configuration settings.
pub const VoiceRecordingConfiguration = struct {
    /// Identifies which IVR track is being recorded.
    ///
    /// One and only one of the track configurations should be presented in the
    /// request.
    ivr_recording_track: ?IvrRecordingTrack = null,

    /// Identifies which track is being recorded.
    voice_recording_track: ?VoiceRecordingTrack = null,

    pub const json_field_names = .{
        .ivr_recording_track = "IvrRecordingTrack",
        .voice_recording_track = "VoiceRecordingTrack",
    };
};
