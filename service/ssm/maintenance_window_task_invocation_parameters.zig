const MaintenanceWindowAutomationParameters = @import("maintenance_window_automation_parameters.zig").MaintenanceWindowAutomationParameters;
const MaintenanceWindowLambdaParameters = @import("maintenance_window_lambda_parameters.zig").MaintenanceWindowLambdaParameters;
const MaintenanceWindowRunCommandParameters = @import("maintenance_window_run_command_parameters.zig").MaintenanceWindowRunCommandParameters;
const MaintenanceWindowStepFunctionsParameters = @import("maintenance_window_step_functions_parameters.zig").MaintenanceWindowStepFunctionsParameters;

/// The parameters for task execution.
pub const MaintenanceWindowTaskInvocationParameters = struct {
    /// The parameters for an `AUTOMATION` task type.
    automation: ?MaintenanceWindowAutomationParameters,

    /// The parameters for a `LAMBDA` task type.
    lambda: ?MaintenanceWindowLambdaParameters,

    /// The parameters for a `RUN_COMMAND` task type.
    run_command: ?MaintenanceWindowRunCommandParameters,

    /// The parameters for a `STEP_FUNCTIONS` task type.
    step_functions: ?MaintenanceWindowStepFunctionsParameters,

    pub const json_field_names = .{
        .automation = "Automation",
        .lambda = "Lambda",
        .run_command = "RunCommand",
        .step_functions = "StepFunctions",
    };
};
