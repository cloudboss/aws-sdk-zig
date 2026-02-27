const CustomConsolidationConfigurationInput = @import("custom_consolidation_configuration_input.zig").CustomConsolidationConfigurationInput;

/// Contains information for modifying a consolidation configuration.
pub const ModifyConsolidationConfiguration = union(enum) {
    /// The updated custom consolidation configuration.
    custom_consolidation_configuration: ?CustomConsolidationConfigurationInput,

    pub const json_field_names = .{
        .custom_consolidation_configuration = "customConsolidationConfiguration",
    };
};
