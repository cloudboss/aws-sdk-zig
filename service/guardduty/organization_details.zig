const OrganizationStatistics = @import("organization_statistics.zig").OrganizationStatistics;

/// Information about GuardDuty coverage statistics for members in your Amazon
/// Web Services organization.
pub const OrganizationDetails = struct {
    /// Information about the GuardDuty coverage statistics for members in your
    /// Amazon Web Services organization.
    organization_statistics: ?OrganizationStatistics = null,

    /// The timestamp at which the organization statistics was last updated. This is
    /// in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .organization_statistics = "OrganizationStatistics",
        .updated_at = "UpdatedAt",
    };
};
