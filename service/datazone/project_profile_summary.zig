const Status = @import("status.zig").Status;

/// The summary of a project profile.
pub const ProjectProfileSummary = struct {
    /// The timestamp of when the project profile was created.
    created_at: ?i64 = null,

    /// The user who created the project profile.
    created_by: []const u8,

    /// The description of the project profile.
    description: ?[]const u8 = null,

    /// The domain ID of the project profile.
    domain_id: []const u8,

    /// The domain unit ID of the project profile.
    domain_unit_id: ?[]const u8 = null,

    /// The ID of the project profile.
    id: []const u8,

    /// The timestamp at which a project profile was last updated.
    last_updated_at: ?i64 = null,

    /// The name of a project profile.
    name: []const u8,

    /// The status of a project profile.
    status: ?Status = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .domain_unit_id = "domainUnitId",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .status = "status",
    };
};
