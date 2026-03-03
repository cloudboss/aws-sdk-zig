const AppflowIntegrationWorkflowAttributes = @import("appflow_integration_workflow_attributes.zig").AppflowIntegrationWorkflowAttributes;

/// Structure to hold workflow attributes.
pub const WorkflowAttributes = struct {
    /// Workflow attributes specific to `APPFLOW_INTEGRATION` workflow.
    appflow_integration: ?AppflowIntegrationWorkflowAttributes = null,

    pub const json_field_names = .{
        .appflow_integration = "AppflowIntegration",
    };
};
