const AppflowIntegration = @import("appflow_integration.zig").AppflowIntegration;

/// Configuration data for integration workflow.
pub const IntegrationConfig = struct {
    /// Configuration data for `APPFLOW_INTEGRATION` workflow type.
    appflow_integration: ?AppflowIntegration,

    pub const json_field_names = .{
        .appflow_integration = "AppflowIntegration",
    };
};
