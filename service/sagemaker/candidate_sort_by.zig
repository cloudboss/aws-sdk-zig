pub const CandidateSortBy = enum {
    creation_time,
    status,
    final_objective_metric_value,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .status = "Status",
        .final_objective_metric_value = "FinalObjectiveMetricValue",
    };
};
