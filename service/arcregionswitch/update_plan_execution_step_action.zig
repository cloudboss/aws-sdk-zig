pub const UpdatePlanExecutionStepAction = enum {
    switch_to_ungraceful,
    skip,

    pub const json_field_names = .{
        .switch_to_ungraceful = "SWITCH_TO_UNGRACEFUL",
        .skip = "SKIP",
    };
};
