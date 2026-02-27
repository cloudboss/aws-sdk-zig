const ExternalAccessFindingsStatistics = @import("external_access_findings_statistics.zig").ExternalAccessFindingsStatistics;
const InternalAccessFindingsStatistics = @import("internal_access_findings_statistics.zig").InternalAccessFindingsStatistics;
const UnusedAccessFindingsStatistics = @import("unused_access_findings_statistics.zig").UnusedAccessFindingsStatistics;

/// Contains information about the aggregate statistics for an external or
/// unused access analyzer. Only one parameter can be used in a
/// `FindingsStatistics` object.
pub const FindingsStatistics = union(enum) {
    /// The aggregate statistics for an external access analyzer.
    external_access_findings_statistics: ?ExternalAccessFindingsStatistics,
    /// The aggregate statistics for an internal access analyzer. This includes
    /// information about active, archived, and resolved findings related to
    /// internal access within your Amazon Web Services organization or account.
    internal_access_findings_statistics: ?InternalAccessFindingsStatistics,
    /// The aggregate statistics for an unused access analyzer.
    unused_access_findings_statistics: ?UnusedAccessFindingsStatistics,

    pub const json_field_names = .{
        .external_access_findings_statistics = "externalAccessFindingsStatistics",
        .internal_access_findings_statistics = "internalAccessFindingsStatistics",
        .unused_access_findings_statistics = "unusedAccessFindingsStatistics",
    };
};
