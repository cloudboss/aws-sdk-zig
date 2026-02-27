const OrganizationCustomPolicyRuleMetadataNoPolicy = @import("organization_custom_policy_rule_metadata_no_policy.zig").OrganizationCustomPolicyRuleMetadataNoPolicy;
const OrganizationCustomRuleMetadata = @import("organization_custom_rule_metadata.zig").OrganizationCustomRuleMetadata;
const OrganizationManagedRuleMetadata = @import("organization_managed_rule_metadata.zig").OrganizationManagedRuleMetadata;

/// An organization Config rule that has information about Config rules that
/// Config creates in member accounts.
pub const OrganizationConfigRule = struct {
    /// A comma-separated list of accounts excluded from organization Config rule.
    excluded_accounts: ?[]const []const u8,

    /// The timestamp of the last update.
    last_update_time: ?i64,

    /// Amazon Resource Name (ARN) of organization Config rule.
    organization_config_rule_arn: []const u8,

    /// The name that you assign to organization Config rule.
    organization_config_rule_name: []const u8,

    /// An
    /// object that specifies metadata for your organization's Config Custom Policy
    /// rule. The metadata includes the runtime system in use, which accounts have
    /// debug logging enabled, and other custom rule metadata, such as resource
    /// type, resource
    /// ID of Amazon Web Services resource, and organization trigger types that
    /// initiate Config to evaluate Amazon Web Services resources against a rule.
    organization_custom_policy_rule_metadata: ?OrganizationCustomPolicyRuleMetadataNoPolicy,

    /// An `OrganizationCustomRuleMetadata` object.
    organization_custom_rule_metadata: ?OrganizationCustomRuleMetadata,

    /// An `OrganizationManagedRuleMetadata` object.
    organization_managed_rule_metadata: ?OrganizationManagedRuleMetadata,

    pub const json_field_names = .{
        .excluded_accounts = "ExcludedAccounts",
        .last_update_time = "LastUpdateTime",
        .organization_config_rule_arn = "OrganizationConfigRuleArn",
        .organization_config_rule_name = "OrganizationConfigRuleName",
        .organization_custom_policy_rule_metadata = "OrganizationCustomPolicyRuleMetadata",
        .organization_custom_rule_metadata = "OrganizationCustomRuleMetadata",
        .organization_managed_rule_metadata = "OrganizationManagedRuleMetadata",
    };
};
