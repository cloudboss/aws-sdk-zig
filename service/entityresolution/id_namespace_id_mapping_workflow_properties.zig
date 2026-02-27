const IdMappingType = @import("id_mapping_type.zig").IdMappingType;
const NamespaceProviderProperties = @import("namespace_provider_properties.zig").NamespaceProviderProperties;
const NamespaceRuleBasedProperties = @import("namespace_rule_based_properties.zig").NamespaceRuleBasedProperties;

/// An object containing `idMappingType`, `providerProperties`, and
/// `ruleBasedProperties`.
pub const IdNamespaceIdMappingWorkflowProperties = struct {
    /// The type of ID mapping.
    id_mapping_type: IdMappingType,

    /// An object which defines any additional configurations required by the
    /// provider service.
    provider_properties: ?NamespaceProviderProperties,

    /// An object which defines any additional configurations required by rule-based
    /// matching.
    rule_based_properties: ?NamespaceRuleBasedProperties,

    pub const json_field_names = .{
        .id_mapping_type = "idMappingType",
        .provider_properties = "providerProperties",
        .rule_based_properties = "ruleBasedProperties",
    };
};
