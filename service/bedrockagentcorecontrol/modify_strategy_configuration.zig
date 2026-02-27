const ModifyConsolidationConfiguration = @import("modify_consolidation_configuration.zig").ModifyConsolidationConfiguration;
const ModifyExtractionConfiguration = @import("modify_extraction_configuration.zig").ModifyExtractionConfiguration;
const ModifyReflectionConfiguration = @import("modify_reflection_configuration.zig").ModifyReflectionConfiguration;
const ModifySelfManagedConfiguration = @import("modify_self_managed_configuration.zig").ModifySelfManagedConfiguration;

/// Contains information for modifying a strategy configuration.
pub const ModifyStrategyConfiguration = struct {
    /// The updated consolidation configuration.
    consolidation: ?ModifyConsolidationConfiguration,

    /// The updated extraction configuration.
    extraction: ?ModifyExtractionConfiguration,

    /// The updated reflection configuration.
    reflection: ?ModifyReflectionConfiguration,

    /// The updated self-managed configuration.
    self_managed_configuration: ?ModifySelfManagedConfiguration,

    pub const json_field_names = .{
        .consolidation = "consolidation",
        .extraction = "extraction",
        .reflection = "reflection",
        .self_managed_configuration = "selfManagedConfiguration",
    };
};
