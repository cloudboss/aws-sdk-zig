const AudioLanguageConfiguration = @import("audio_language_configuration.zig").AudioLanguageConfiguration;
const ModalityProcessingConfiguration = @import("modality_processing_configuration.zig").ModalityProcessingConfiguration;
const SensitiveDataConfiguration = @import("sensitive_data_configuration.zig").SensitiveDataConfiguration;

/// Override Configuration of Audio
pub const AudioOverrideConfiguration = struct {
    language_configuration: ?AudioLanguageConfiguration = null,

    modality_processing: ?ModalityProcessingConfiguration = null,

    sensitive_data_configuration: ?SensitiveDataConfiguration = null,

    pub const json_field_names = .{
        .language_configuration = "languageConfiguration",
        .modality_processing = "modalityProcessing",
        .sensitive_data_configuration = "sensitiveDataConfiguration",
    };
};
