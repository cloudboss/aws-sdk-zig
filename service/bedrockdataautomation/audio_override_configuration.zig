const AudioLanguageConfiguration = @import("audio_language_configuration.zig").AudioLanguageConfiguration;
const ModalityProcessingConfiguration = @import("modality_processing_configuration.zig").ModalityProcessingConfiguration;
const SensitiveDataConfiguration = @import("sensitive_data_configuration.zig").SensitiveDataConfiguration;

/// Override Configuration of Audio
pub const AudioOverrideConfiguration = struct {
    language_configuration: ?AudioLanguageConfiguration,

    modality_processing: ?ModalityProcessingConfiguration,

    sensitive_data_configuration: ?SensitiveDataConfiguration,

    pub const json_field_names = .{
        .language_configuration = "languageConfiguration",
        .modality_processing = "modalityProcessing",
        .sensitive_data_configuration = "sensitiveDataConfiguration",
    };
};
