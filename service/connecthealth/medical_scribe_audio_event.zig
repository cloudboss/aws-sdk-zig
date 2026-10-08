/// An event containing audio data for the Medical Scribe stream
pub const MedicalScribeAudioEvent = struct {
    /// The audio data chunk
    audio_chunk: []const u8,

    pub const json_field_names = .{
        .audio_chunk = "audioChunk",
    };
};
