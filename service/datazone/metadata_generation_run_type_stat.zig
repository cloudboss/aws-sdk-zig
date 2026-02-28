const MetadataGenerationRunStatus = @import("metadata_generation_run_status.zig").MetadataGenerationRunStatus;
const MetadataGenerationRunType = @import("metadata_generation_run_type.zig").MetadataGenerationRunType;

/// The statistics of the metadata generation run type.
pub const MetadataGenerationRunTypeStat = struct {
    /// The error message displayed if the action fails to run.
    error_message: ?[]const u8,

    /// The status of the metadata generation run type statistics.
    status: MetadataGenerationRunStatus,

    /// The type of the metadata generation run type statistics.
    @"type": MetadataGenerationRunType,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .status = "status",
        .@"type" = "type",
    };
};
