/// Contains a chunk of synthesized audio data.
pub const AudioEvent = struct {
    /// A chunk of synthesized audio data encoded in the format specified by the
    /// `OutputFormat` parameter.
    audio_chunk: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_chunk = "AudioChunk",
    };
};
