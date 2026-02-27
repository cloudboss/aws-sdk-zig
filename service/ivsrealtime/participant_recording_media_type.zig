pub const ParticipantRecordingMediaType = enum {
    audio_video,
    audio_only,
    none,

    pub const json_field_names = .{
        .audio_video = "AUDIO_VIDEO",
        .audio_only = "AUDIO_ONLY",
        .none = "NONE",
    };
};
