const FindingsFound = @import("findings_found.zig").FindingsFound;
const AnalysisStatus = @import("analysis_status.zig").AnalysisStatus;
const Tag = @import("tag.zig").Tag;

/// Describes a Network Access Scope analysis.
pub const NetworkInsightsAccessScopeAnalysis = struct {
    /// The number of network interfaces analyzed.
    analyzed_eni_count: ?i32 = null,

    /// The analysis end date.
    end_date: ?i64 = null,

    /// Indicates whether there are findings.
    findings_found: ?FindingsFound = null,

    /// The Amazon Resource Name (ARN) of the Network Access Scope analysis.
    network_insights_access_scope_analysis_arn: ?[]const u8 = null,

    /// The ID of the Network Access Scope analysis.
    network_insights_access_scope_analysis_id: ?[]const u8 = null,

    /// The ID of the Network Access Scope.
    network_insights_access_scope_id: ?[]const u8 = null,

    /// The analysis start date.
    start_date: ?i64 = null,

    /// The status.
    status: ?AnalysisStatus = null,

    /// The status message.
    status_message: ?[]const u8 = null,

    /// The tags.
    tags: ?[]const Tag = null,

    /// The warning message.
    warning_message: ?[]const u8 = null,
};
