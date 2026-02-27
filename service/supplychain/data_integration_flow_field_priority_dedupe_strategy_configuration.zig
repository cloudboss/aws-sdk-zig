const DataIntegrationFlowFieldPriorityDedupeField = @import("data_integration_flow_field_priority_dedupe_field.zig").DataIntegrationFlowFieldPriorityDedupeField;

/// The field priority deduplication strategy details.
pub const DataIntegrationFlowFieldPriorityDedupeStrategyConfiguration = struct {
    /// The list of field names and their sort order for deduplication, arranged in
    /// descending priority from highest to lowest.
    fields: []const DataIntegrationFlowFieldPriorityDedupeField,

    pub const json_field_names = .{
        .fields = "fields",
    };
};
