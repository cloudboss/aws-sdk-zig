const MetadataGenerationRunStatus = @import("metadata_generation_run_status.zig").MetadataGenerationRunStatus;
const MetadataGenerationRunTarget = @import("metadata_generation_run_target.zig").MetadataGenerationRunTarget;
const MetadataGenerationRunType = @import("metadata_generation_run_type.zig").MetadataGenerationRunType;

/// The metadata generation run.
pub const MetadataGenerationRunItem = struct {
    /// The timestamp at which the metadata generation run was created.
    created_at: ?i64,

    /// The user who created the metadata generation run.
    created_by: ?[]const u8,

    /// The ID of the Amazon DataZone domain in which the metadata generation run
    /// was created.
    domain_id: []const u8,

    /// The ID of the metadata generation run.
    id: []const u8,

    /// The ID of the project that owns the asset for which the metadata generation
    /// was ran.
    owning_project_id: []const u8,

    /// The status of the metadata generation run.
    status: ?MetadataGenerationRunStatus,

    /// The asset for which metadata was generated.
    target: ?MetadataGenerationRunTarget,

    /// The type of the metadata generation run.
    type: ?MetadataGenerationRunType,

    /// The types of the metadata generation run.
    types: ?[]const MetadataGenerationRunType,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .id = "id",
        .owning_project_id = "owningProjectId",
        .status = "status",
        .target = "target",
        .type = "type",
        .types = "types",
    };
};
