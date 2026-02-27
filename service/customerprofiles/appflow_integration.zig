const Batch = @import("batch.zig").Batch;
const FlowDefinition = @import("flow_definition.zig").FlowDefinition;

/// Details for workflow of type `APPFLOW_INTEGRATION`.
pub const AppflowIntegration = struct {
    /// Batches in workflow of type `APPFLOW_INTEGRATION`.
    batches: ?[]const Batch,

    flow_definition: FlowDefinition,

    pub const json_field_names = .{
        .batches = "Batches",
        .flow_definition = "FlowDefinition",
    };
};
