const CustomConsolidationConfiguration = @import("custom_consolidation_configuration.zig").CustomConsolidationConfiguration;

/// Contains consolidation configuration information for a memory strategy.
pub const ConsolidationConfiguration = union(enum) {
    /// The custom consolidation configuration.
    custom_consolidation_configuration: ?CustomConsolidationConfiguration,

    pub const json_field_names = .{
        .custom_consolidation_configuration = "customConsolidationConfiguration",
    };
};
