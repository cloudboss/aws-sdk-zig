const ProviderProperties = @import("provider_properties.zig").ProviderProperties;
const ResolutionType = @import("resolution_type.zig").ResolutionType;
const RuleBasedProperties = @import("rule_based_properties.zig").RuleBasedProperties;
const RuleConditionProperties = @import("rule_condition_properties.zig").RuleConditionProperties;

/// An object which defines the `resolutionType` and the `ruleBasedProperties`.
pub const ResolutionTechniques = struct {
    /// The properties of the provider service.
    provider_properties: ?ProviderProperties,

    /// The type of matching workflow to create. Specify one of the following types:
    ///
    /// * `RULE_MATCHING`: Match records using configurable rule-based criteria
    /// * `ML_MATCHING`: Match records using machine learning models
    /// * `PROVIDER`: Match records using a third-party matching provider
    resolution_type: ResolutionType,

    /// An object which defines the list of matching rules to run and has a field
    /// `rules`, which is a list of rule objects.
    rule_based_properties: ?RuleBasedProperties,

    /// An object containing the `rules` for a matching workflow.
    rule_condition_properties: ?RuleConditionProperties,

    pub const json_field_names = .{
        .provider_properties = "providerProperties",
        .resolution_type = "resolutionType",
        .rule_based_properties = "ruleBasedProperties",
        .rule_condition_properties = "ruleConditionProperties",
    };
};
