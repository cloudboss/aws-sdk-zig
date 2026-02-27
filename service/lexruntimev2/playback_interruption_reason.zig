pub const PlaybackInterruptionReason = enum {
    dtmf_start_detected,
    text_detected,
    voice_start_detected,

    pub const json_field_names = .{
        .dtmf_start_detected = "DTMF_START_DETECTED",
        .text_detected = "TEXT_DETECTED",
        .voice_start_detected = "VOICE_START_DETECTED",
    };
};
