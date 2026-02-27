/// Contains information about the total number of active, archived, and
/// resolved findings for a resource type of an internal access analyzer.
pub const InternalAccessResourceTypeDetails = struct {
    /// The total number of active findings for the resource type in the internal
    /// access analyzer.
    total_active_findings: ?i32,

    /// The total number of archived findings for the resource type in the internal
    /// access analyzer.
    total_archived_findings: ?i32,

    /// The total number of resolved findings for the resource type in the internal
    /// access analyzer.
    total_resolved_findings: ?i32,

    pub const json_field_names = .{
        .total_active_findings = "totalActiveFindings",
        .total_archived_findings = "totalArchivedFindings",
        .total_resolved_findings = "totalResolvedFindings",
    };
};
