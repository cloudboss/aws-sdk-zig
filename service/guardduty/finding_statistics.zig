const aws = @import("aws");

const AccountStatistics = @import("account_statistics.zig").AccountStatistics;
const DateStatistics = @import("date_statistics.zig").DateStatistics;
const FindingTypeStatistics = @import("finding_type_statistics.zig").FindingTypeStatistics;
const ResourceStatistics = @import("resource_statistics.zig").ResourceStatistics;
const SeverityStatistics = @import("severity_statistics.zig").SeverityStatistics;

/// Contains information about finding statistics.
pub const FindingStatistics = struct {
    /// Represents a list of map of severity to count statistics for a set of
    /// findings.
    count_by_severity: ?[]const aws.map.MapEntry(i32) = null,

    /// Represents a list of map of accounts with a findings count associated with
    /// each account.
    grouped_by_account: ?[]const AccountStatistics = null,

    /// Represents a list of map of dates with a count of total findings generated
    /// on each date per severity level.
    grouped_by_date: ?[]const DateStatistics = null,

    /// Represents a list of map of finding types with a count of total findings
    /// generated for each type.
    ///
    /// Based on the `orderBy`
    /// parameter, this request returns either the most occurring finding types or
    /// the least occurring finding types. If the
    /// `orderBy` parameter is `ASC`, this will represent the least occurring
    /// finding types in
    /// your account; otherwise, this will represent the most occurring finding
    /// types. The default
    /// value of `orderBy` is `DESC`.
    grouped_by_finding_type: ?[]const FindingTypeStatistics = null,

    /// Represents a list of map of top resources with a count of total findings.
    grouped_by_resource: ?[]const ResourceStatistics = null,

    /// Represents a list of map of total findings for each severity level.
    grouped_by_severity: ?[]const SeverityStatistics = null,

    pub const json_field_names = .{
        .count_by_severity = "CountBySeverity",
        .grouped_by_account = "GroupedByAccount",
        .grouped_by_date = "GroupedByDate",
        .grouped_by_finding_type = "GroupedByFindingType",
        .grouped_by_resource = "GroupedByResource",
        .grouped_by_severity = "GroupedBySeverity",
    };
};
