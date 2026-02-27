const SpeechFoundationModel = @import("speech_foundation_model.zig").SpeechFoundationModel;

/// Unified configuration settings that combine speech recognition and synthesis
/// capabilities.
pub const UnifiedSpeechSettings = struct {
    /// The foundation model configuration to use for unified speech processing
    /// capabilities.
    speech_foundation_model: SpeechFoundationModel,

    pub const json_field_names = .{
        .speech_foundation_model = "speechFoundationModel",
    };
};
