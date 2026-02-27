const ArtifactStatusFilter = @import("artifact_status_filter.zig").ArtifactStatusFilter;

/// An object representing a filter on a ListImageReferrers operation.
pub const ListImageReferrersFilter = struct {
    /// The artifact status with which to filter your ListImageReferrers results.
    /// Valid values are `ACTIVE`, `ARCHIVED`, `ACTIVATING`, or `ANY`. If not
    /// specified, only artifacts with `ACTIVE` status are returned.
    artifact_status: ?ArtifactStatusFilter,

    /// The artifact types with which to filter your ListImageReferrers results.
    artifact_types: ?[]const []const u8,

    pub const json_field_names = .{
        .artifact_status = "artifactStatus",
        .artifact_types = "artifactTypes",
    };
};
