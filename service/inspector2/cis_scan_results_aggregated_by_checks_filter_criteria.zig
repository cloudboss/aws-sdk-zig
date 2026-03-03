const CisStringFilter = @import("cis_string_filter.zig").CisStringFilter;
const CisNumberFilter = @import("cis_number_filter.zig").CisNumberFilter;
const CisSecurityLevelFilter = @import("cis_security_level_filter.zig").CisSecurityLevelFilter;

/// The scan results aggregated by checks filter criteria.
pub const CisScanResultsAggregatedByChecksFilterCriteria = struct {
    /// The criteria's account ID filters.
    account_id_filters: ?[]const CisStringFilter = null,

    /// The criteria's check ID filters.
    check_id_filters: ?[]const CisStringFilter = null,

    /// The criteria's failed resources filters.
    failed_resources_filters: ?[]const CisNumberFilter = null,

    /// The criteria's platform filters.
    platform_filters: ?[]const CisStringFilter = null,

    /// The criteria's security level filters.
    security_level_filters: ?[]const CisSecurityLevelFilter = null,

    /// The criteria's title filters.
    title_filters: ?[]const CisStringFilter = null,

    pub const json_field_names = .{
        .account_id_filters = "accountIdFilters",
        .check_id_filters = "checkIdFilters",
        .failed_resources_filters = "failedResourcesFilters",
        .platform_filters = "platformFilters",
        .security_level_filters = "securityLevelFilters",
        .title_filters = "titleFilters",
    };
};
