const NotebookStatus = @import("notebook_status.zig").NotebookStatus;
const NotebookType = @import("notebook_type.zig").NotebookType;

/// The summary of a notebook in Amazon SageMaker Unified Studio.
pub const NotebookSummary = struct {
    /// The timestamp of when the notebook was created.
    created_at: ?i64 = null,

    /// The identifier of the user who created the notebook.
    created_by: ?[]const u8 = null,

    /// The description of the notebook.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon SageMaker Unified Studio domain.
    domain_id: []const u8,

    /// The identifier of the notebook.
    id: []const u8,

    /// The name of the notebook.
    name: []const u8,

    /// The identifier of the project that owns the notebook.
    owning_project_id: []const u8,

    /// The status of the notebook.
    status: NotebookStatus,

    /// The type of the notebook.
    @"type": ?NotebookType = null,

    /// The timestamp of when the notebook was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the user who last updated the notebook.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .id = "id",
        .name = "name",
        .owning_project_id = "owningProjectId",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
