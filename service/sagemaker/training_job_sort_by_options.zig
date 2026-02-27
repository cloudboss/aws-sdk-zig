pub const TrainingJobSortByOptions = enum {
    name,
    creation_time,
    status,
    final_objective_metric_value,

    pub const json_field_names = .{
        .name = "Name",
        .creation_time = "CreationTime",
        .status = "Status",
        .final_objective_metric_value = "FinalObjectiveMetricValue",
    };
};
