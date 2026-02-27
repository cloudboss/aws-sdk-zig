const PrivacyConfigurationPolicies = @import("privacy_configuration_policies.zig").PrivacyConfigurationPolicies;

/// Information about the privacy configuration for a configured model algorithm
/// association.
pub const PrivacyConfiguration = struct {
    /// The privacy configuration policies for a configured model algorithm
    /// association.
    policies: PrivacyConfigurationPolicies,

    pub const json_field_names = .{
        .policies = "policies",
    };
};
