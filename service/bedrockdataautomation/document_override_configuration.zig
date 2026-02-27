const ModalityProcessingConfiguration = @import("modality_processing_configuration.zig").ModalityProcessingConfiguration;
const SensitiveDataConfiguration = @import("sensitive_data_configuration.zig").SensitiveDataConfiguration;
const SplitterConfiguration = @import("splitter_configuration.zig").SplitterConfiguration;

/// Override Configuration of Document
pub const DocumentOverrideConfiguration = struct {
    modality_processing: ?ModalityProcessingConfiguration,

    sensitive_data_configuration: ?SensitiveDataConfiguration,

    splitter: ?SplitterConfiguration,

    pub const json_field_names = .{
        .modality_processing = "modalityProcessing",
        .sensitive_data_configuration = "sensitiveDataConfiguration",
        .splitter = "splitter",
    };
};
