pub const AnomalyFeedbackType = enum {
    yes,
    no,
    planned_activity,

    pub const json_field_names = .{
        .yes = "YES",
        .no = "NO",
        .planned_activity = "PLANNED_ACTIVITY",
    };
};
