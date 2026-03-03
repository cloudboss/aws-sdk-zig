const ConsolidationConfiguration = @import("consolidation_configuration.zig").ConsolidationConfiguration;
const ExtractionConfiguration = @import("extraction_configuration.zig").ExtractionConfiguration;
const ReflectionConfiguration = @import("reflection_configuration.zig").ReflectionConfiguration;
const SelfManagedConfiguration = @import("self_managed_configuration.zig").SelfManagedConfiguration;
const OverrideType = @import("override_type.zig").OverrideType;

/// Contains configuration information for a memory strategy.
pub const StrategyConfiguration = struct {
    /// The consolidation configuration for the memory strategy.
    consolidation: ?ConsolidationConfiguration = null,

    /// The extraction configuration for the memory strategy.
    extraction: ?ExtractionConfiguration = null,

    /// The reflection configuration for the memory strategy.
    reflection: ?ReflectionConfiguration = null,

    /// Self-managed configuration settings.
    self_managed_configuration: ?SelfManagedConfiguration = null,

    /// The type of override for the strategy configuration.
    @"type": ?OverrideType = null,

    pub const json_field_names = .{
        .consolidation = "consolidation",
        .extraction = "extraction",
        .reflection = "reflection",
        .self_managed_configuration = "selfManagedConfiguration",
        .@"type" = "type",
    };
};
