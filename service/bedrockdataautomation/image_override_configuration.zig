const ModalityProcessingConfiguration = @import("modality_processing_configuration.zig").ModalityProcessingConfiguration;
const SensitiveDataConfiguration = @import("sensitive_data_configuration.zig").SensitiveDataConfiguration;

/// Override Configuration of Image
pub const ImageOverrideConfiguration = struct {
    modality_processing: ?ModalityProcessingConfiguration,

    sensitive_data_configuration: ?SensitiveDataConfiguration,

    pub const json_field_names = .{
        .modality_processing = "modalityProcessing",
        .sensitive_data_configuration = "sensitiveDataConfiguration",
    };
};
