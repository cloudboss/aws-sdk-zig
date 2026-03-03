const AppflowIntegrationWorkflowStep = @import("appflow_integration_workflow_step.zig").AppflowIntegrationWorkflowStep;

/// List containing steps in workflow.
pub const WorkflowStepItem = struct {
    /// Workflow step information specific to `APPFLOW_INTEGRATION` workflow.
    appflow_integration: ?AppflowIntegrationWorkflowStep = null,

    pub const json_field_names = .{
        .appflow_integration = "AppflowIntegration",
    };
};
