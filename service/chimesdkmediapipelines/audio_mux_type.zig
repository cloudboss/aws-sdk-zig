pub const AudioMuxType = enum {
    audio_only,
    audio_with_active_speaker_video,
    audio_with_composited_video,

    pub const json_field_names = .{
        .audio_only = "AudioOnly",
        .audio_with_active_speaker_video = "AudioWithActiveSpeakerVideo",
        .audio_with_composited_video = "AudioWithCompositedVideo",
    };
};
