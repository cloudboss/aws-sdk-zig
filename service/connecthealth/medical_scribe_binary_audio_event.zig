/// An event containing raw binary audio data for the Medical Scribe stream. The
/// audio is sent as a raw binary payload rather than as a base64-encoded value.
pub const MedicalScribeBinaryAudioEvent = struct {
    /// The raw binary audio data chunk
    audio_chunk: []const u8,

    pub const json_field_names = .{
        .audio_chunk = "audioChunk",
    };
};
