/// Specifies the allowed input types.
pub const AllowedInputTypes = struct {
    /// Indicates whether audio input is allowed.
    allow_audio_input: bool,

    /// Indicates whether DTMF input is allowed.
    allow_dtmf_input: bool,

    pub const json_field_names = .{
        .allow_audio_input = "allowAudioInput",
        .allow_dtmf_input = "allowDTMFInput",
    };
};
