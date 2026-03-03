const RuleTypeId = @import("rule_type_id.zig").RuleTypeId;
const ArtifactDetails = @import("artifact_details.zig").ArtifactDetails;
const RuleConfigurationProperty = @import("rule_configuration_property.zig").RuleConfigurationProperty;
const RuleTypeSettings = @import("rule_type_settings.zig").RuleTypeSettings;

/// The rule type, which is made up of the combined values for category, owner,
/// provider,
/// and version.
pub const RuleType = struct {
    /// Represents information about a rule type.
    id: RuleTypeId,

    input_artifact_details: ArtifactDetails,

    /// The configuration properties for the rule type.
    rule_configuration_properties: ?[]const RuleConfigurationProperty = null,

    /// Returns information about the settings for a rule type.
    settings: ?RuleTypeSettings = null,

    pub const json_field_names = .{
        .id = "id",
        .input_artifact_details = "inputArtifactDetails",
        .rule_configuration_properties = "ruleConfigurationProperties",
        .settings = "settings",
    };
};
