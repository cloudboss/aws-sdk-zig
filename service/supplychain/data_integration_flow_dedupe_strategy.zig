const DataIntegrationFlowFieldPriorityDedupeStrategyConfiguration = @import("data_integration_flow_field_priority_dedupe_strategy_configuration.zig").DataIntegrationFlowFieldPriorityDedupeStrategyConfiguration;
const DataIntegrationFlowDedupeStrategyType = @import("data_integration_flow_dedupe_strategy_type.zig").DataIntegrationFlowDedupeStrategyType;

/// The deduplication strategy details.
pub const DataIntegrationFlowDedupeStrategy = struct {
    /// The field priority deduplication strategy.
    field_priority: ?DataIntegrationFlowFieldPriorityDedupeStrategyConfiguration = null,

    /// The type of the deduplication strategy.
    ///
    /// * **FIELD_PRIORITY** - Field priority configuration for the deduplication
    ///   strategy specifies an ordered list of fields used to tie-break the data
    ///   records sharing the same primary key values. Fields earlier in the list
    ///   have higher priority for evaluation. For each field, the sort order
    ///   determines whether to retain data record with larger or smaller field
    ///   value.
    @"type": DataIntegrationFlowDedupeStrategyType,

    pub const json_field_names = .{
        .field_priority = "fieldPriority",
        .@"type" = "type",
    };
};
