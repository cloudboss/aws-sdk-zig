const CisStringFilter = @import("cis_string_filter.zig").CisStringFilter;
const CisFindingStatusFilter = @import("cis_finding_status_filter.zig").CisFindingStatusFilter;
const CisSecurityLevelFilter = @import("cis_security_level_filter.zig").CisSecurityLevelFilter;

/// The CIS scan result details filter criteria.
pub const CisScanResultDetailsFilterCriteria = struct {
    /// The criteria's check ID filters.
    check_id_filters: ?[]const CisStringFilter = null,

    /// The criteria's finding ARN filters.
    finding_arn_filters: ?[]const CisStringFilter = null,

    /// The criteria's finding status filters.
    finding_status_filters: ?[]const CisFindingStatusFilter = null,

    /// The criteria's security level filters. . Security level refers to the
    /// Benchmark levels
    /// that CIS assigns to a profile.
    security_level_filters: ?[]const CisSecurityLevelFilter = null,

    /// The criteria's title filters.
    title_filters: ?[]const CisStringFilter = null,

    pub const json_field_names = .{
        .check_id_filters = "checkIdFilters",
        .finding_arn_filters = "findingArnFilters",
        .finding_status_filters = "findingStatusFilters",
        .security_level_filters = "securityLevelFilters",
        .title_filters = "titleFilters",
    };
};
