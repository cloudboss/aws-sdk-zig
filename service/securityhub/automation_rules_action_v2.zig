const ExternalIntegrationConfiguration = @import("external_integration_configuration.zig").ExternalIntegrationConfiguration;
const AutomationRulesFindingFieldsUpdateV2 = @import("automation_rules_finding_fields_update_v2.zig").AutomationRulesFindingFieldsUpdateV2;
const AutomationRulesActionTypeV2 = @import("automation_rules_action_type_v2.zig").AutomationRulesActionTypeV2;

/// Allows you to configure automated responses.
pub const AutomationRulesActionV2 = struct {
    /// The settings for integrating automation rule actions with external systems
    /// or service.
    external_integration_configuration: ?ExternalIntegrationConfiguration = null,

    /// The changes to be applied to fields in a security finding when an automation
    /// rule is triggered.
    finding_fields_update: ?AutomationRulesFindingFieldsUpdateV2 = null,

    /// The category of action to be executed by the automation rule.
    @"type": AutomationRulesActionTypeV2,

    pub const json_field_names = .{
        .external_integration_configuration = "ExternalIntegrationConfiguration",
        .finding_fields_update = "FindingFieldsUpdate",
        .@"type" = "Type",
    };
};
