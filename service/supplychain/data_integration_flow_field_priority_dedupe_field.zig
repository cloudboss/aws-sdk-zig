const DataIntegrationFlowFieldPriorityDedupeSortOrder = @import("data_integration_flow_field_priority_dedupe_sort_order.zig").DataIntegrationFlowFieldPriorityDedupeSortOrder;

/// The field used in the field priority deduplication strategy.
pub const DataIntegrationFlowFieldPriorityDedupeField = struct {
    /// The name of the deduplication field. Must exist in the dataset and not be a
    /// primary key.
    name: []const u8,

    /// The sort order for the deduplication field.
    sort_order: DataIntegrationFlowFieldPriorityDedupeSortOrder,

    pub const json_field_names = .{
        .name = "name",
        .sort_order = "sortOrder",
    };
};
