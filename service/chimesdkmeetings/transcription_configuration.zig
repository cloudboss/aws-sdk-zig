const EngineTranscribeMedicalSettings = @import("engine_transcribe_medical_settings.zig").EngineTranscribeMedicalSettings;
const EngineTranscribeSettings = @import("engine_transcribe_settings.zig").EngineTranscribeSettings;

/// The configuration for the current transcription operation. Must contain
/// `EngineTranscribeSettings` or `EngineTranscribeMedicalSettings`.
pub const TranscriptionConfiguration = struct {
    /// The transcription configuration settings passed to Amazon Transcribe
    /// Medical.
    engine_transcribe_medical_settings: ?EngineTranscribeMedicalSettings,

    /// The transcription configuration settings passed to Amazon Transcribe.
    engine_transcribe_settings: ?EngineTranscribeSettings,

    pub const json_field_names = .{
        .engine_transcribe_medical_settings = "EngineTranscribeMedicalSettings",
        .engine_transcribe_settings = "EngineTranscribeSettings",
    };
};
