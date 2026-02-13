pub const MaintenanceWindowTaskType = enum {
    run_command,
    automation,
    step_functions,
    lambda,

    pub const json_field_names = .{
        .run_command = "RunCommand",
        .automation = "Automation",
        .step_functions = "StepFunctions",
        .lambda = "Lambda",
    };
};
