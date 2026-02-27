/// The improvement status for a workload.
pub const WorkloadImprovementStatus = enum {
    not_applicable,
    not_started,
    in_progress,
    complete,
    risk_acknowledged,

    pub const json_field_names = .{
        .not_applicable = "NOT_APPLICABLE",
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .risk_acknowledged = "RISK_ACKNOWLEDGED",
    };
};
