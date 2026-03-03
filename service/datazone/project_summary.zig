const ProjectDeletionError = @import("project_deletion_error.zig").ProjectDeletionError;
const ProjectStatus = @import("project_status.zig").ProjectStatus;

/// The details of a Amazon DataZone project.
pub const ProjectSummary = struct {
    /// The timestamp of when a project was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the project.
    created_by: []const u8,

    /// The description of a project.
    description: ?[]const u8 = null,

    /// The identifier of a Amazon DataZone domain where the project exists.
    domain_id: []const u8,

    /// The ID of the domain unit.
    domain_unit_id: ?[]const u8 = null,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    failure_reasons: ?[]const ProjectDeletionError = null,

    /// The identifier of a project.
    id: []const u8,

    /// The name of a project.
    name: []const u8,

    /// The status of the project.
    project_status: ?ProjectStatus = null,

    /// The timestamp of when the project was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .domain_unit_id = "domainUnitId",
        .failure_reasons = "failureReasons",
        .id = "id",
        .name = "name",
        .project_status = "projectStatus",
        .updated_at = "updatedAt",
    };
};
