const Hits = @import("hits.zig").Hits;
const UniqueSources = @import("unique_sources.zig").UniqueSources;

/// The results of a `COMPLETED` analysis report generated with
/// StartAnalysisReport.
///
/// For an example of traffic analysis report results, see the response syntax
/// of GetAnalysisReportResults.
pub const AnalysisTypeReportResult = struct {
    /// The most frequently accessed domains.
    domain: ?[]const u8 = null,

    /// The date and time any domain was first accessed (within the last 30 day
    /// period).
    first_accessed: ?i64 = null,

    /// The number of attempts made to access a observed domain.
    hits: ?Hits = null,

    /// The date and time any domain was last accessed (within the last 30 day
    /// period).
    last_accessed: ?i64 = null,

    /// The type of traffic captured by the analysis report.
    protocol: ?[]const u8 = null,

    /// The number of unique source IP addresses that connected to a domain.
    unique_sources: ?UniqueSources = null,

    pub const json_field_names = .{
        .domain = "Domain",
        .first_accessed = "FirstAccessed",
        .hits = "Hits",
        .last_accessed = "LastAccessed",
        .protocol = "Protocol",
        .unique_sources = "UniqueSources",
    };
};
