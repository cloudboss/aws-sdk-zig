/// Provides summary counts of how many tasks for findings are in a particular
/// state. This information is included in the response from
/// DescribeAuditMitigationActionsTask.
pub const TaskStatisticsForAuditCheck = struct {
    /// The number of findings to which the mitigation action task was canceled when
    /// applied.
    canceled_findings_count: ?i64,

    /// The number of findings for which at least one of the actions failed when
    /// applied.
    failed_findings_count: ?i64,

    /// The number of findings skipped because of filter conditions provided in the
    /// parameters to the command.
    skipped_findings_count: ?i64,

    /// The number of findings for which all mitigation actions succeeded when
    /// applied.
    succeeded_findings_count: ?i64,

    /// The total number of findings to which a task is being applied.
    total_findings_count: ?i64,

    pub const json_field_names = .{
        .canceled_findings_count = "canceledFindingsCount",
        .failed_findings_count = "failedFindingsCount",
        .skipped_findings_count = "skippedFindingsCount",
        .succeeded_findings_count = "succeededFindingsCount",
        .total_findings_count = "totalFindingsCount",
    };
};
