pub const UpdatePlanExecutionAction = enum {
    switch_to_graceful,
    switch_to_ungraceful,
    pause,
    @"resume",

    pub const json_field_names = .{
        .switch_to_graceful = "SWITCH_TO_GRACEFUL",
        .switch_to_ungraceful = "SWITCH_TO_UNGRACEFUL",
        .pause = "PAUSE",
        .@"resume" = "RESUME",
    };
};
