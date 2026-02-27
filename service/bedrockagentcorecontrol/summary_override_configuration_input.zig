const SummaryOverrideConsolidationConfigurationInput = @import("summary_override_consolidation_configuration_input.zig").SummaryOverrideConsolidationConfigurationInput;

/// Input for summary override configuration in a memory strategy.
pub const SummaryOverrideConfigurationInput = struct {
    /// The consolidation configuration for a summary override.
    consolidation: ?SummaryOverrideConsolidationConfigurationInput,

    pub const json_field_names = .{
        .consolidation = "consolidation",
    };
};
