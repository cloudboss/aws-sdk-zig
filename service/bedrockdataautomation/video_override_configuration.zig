const ModalityProcessingConfiguration = @import("modality_processing_configuration.zig").ModalityProcessingConfiguration;
const SensitiveDataConfiguration = @import("sensitive_data_configuration.zig").SensitiveDataConfiguration;

/// Override Configuration of Video
pub const VideoOverrideConfiguration = struct {
    modality_processing: ?ModalityProcessingConfiguration = null,

    sensitive_data_configuration: ?SensitiveDataConfiguration = null,

    pub const json_field_names = .{
        .modality_processing = "modalityProcessing",
        .sensitive_data_configuration = "sensitiveDataConfiguration",
    };
};
