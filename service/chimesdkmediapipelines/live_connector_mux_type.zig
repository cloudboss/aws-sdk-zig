pub const LiveConnectorMuxType = enum {
    audio_with_composited_video,
    audio_with_active_speaker_video,

    pub const json_field_names = .{
        .audio_with_composited_video = "AudioWithCompositedVideo",
        .audio_with_active_speaker_video = "AudioWithActiveSpeakerVideo",
    };
};
