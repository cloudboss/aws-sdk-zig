pub const TrainingPlanSortBy = enum {
    name,
    start_time,
    status,

    pub const json_field_names = .{
        .name = "NAME",
        .start_time = "START_TIME",
        .status = "STATUS",
    };
};
