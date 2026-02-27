const AppflowIntegrationWorkflowMetrics = @import("appflow_integration_workflow_metrics.zig").AppflowIntegrationWorkflowMetrics;

/// Generic object containing workflow execution metrics.
pub const WorkflowMetrics = struct {
    /// Workflow execution metrics for `APPFLOW_INTEGRATION` workflow.
    appflow_integration: ?AppflowIntegrationWorkflowMetrics,

    pub const json_field_names = .{
        .appflow_integration = "AppflowIntegration",
    };
};
