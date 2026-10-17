const ResourceCriticality = @import("resource_criticality.zig").ResourceCriticality;

/// Allows you to define the structure for modifying specific fields of
/// resources.
pub const AutomationRulesResourceFieldsUpdateV2 = struct {
    /// The criticality level to be assigned to resources that match the automation
    /// rule criteria.
    criticality: ResourceCriticality,

    pub const json_field_names = .{
        .criticality = "Criticality",
    };
};
