const TrainedModelExportFileType = @import("trained_model_export_file_type.zig").TrainedModelExportFileType;
const TrainedModelExportsMaxSize = @import("trained_model_exports_max_size.zig").TrainedModelExportsMaxSize;

/// Information about how the trained model exports are configured.
pub const TrainedModelExportsConfigurationPolicy = struct {
    /// The files that are exported during the trained model export job.
    files_to_export: []const TrainedModelExportFileType,

    /// The maximum size of the data that can be exported.
    max_size: TrainedModelExportsMaxSize,

    pub const json_field_names = .{
        .files_to_export = "filesToExport",
        .max_size = "maxSize",
    };
};
