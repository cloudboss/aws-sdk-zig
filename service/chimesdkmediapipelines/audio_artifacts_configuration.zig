const AudioMuxType = @import("audio_mux_type.zig").AudioMuxType;

/// The audio artifact configuration object.
pub const AudioArtifactsConfiguration = struct {
    /// The MUX type of the audio artifact configuration object.
    mux_type: AudioMuxType,

    pub const json_field_names = .{
        .mux_type = "MuxType",
    };
};
