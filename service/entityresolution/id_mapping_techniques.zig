const IdMappingType = @import("id_mapping_type.zig").IdMappingType;
const ProviderProperties = @import("provider_properties.zig").ProviderProperties;
const IdMappingRuleBasedProperties = @import("id_mapping_rule_based_properties.zig").IdMappingRuleBasedProperties;

/// An object which defines the ID mapping technique and any additional
/// configurations.
pub const IdMappingTechniques = struct {
    /// The type of ID mapping.
    id_mapping_type: IdMappingType,

    /// An object which defines any additional configurations required by the
    /// provider service.
    provider_properties: ?ProviderProperties,

    /// An object which defines any additional configurations required by rule-based
    /// matching.
    rule_based_properties: ?IdMappingRuleBasedProperties,

    pub const json_field_names = .{
        .id_mapping_type = "idMappingType",
        .provider_properties = "providerProperties",
        .rule_based_properties = "ruleBasedProperties",
    };
};
