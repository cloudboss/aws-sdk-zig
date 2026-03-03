const AdvancedSecurityAdditionalFlowsType = @import("advanced_security_additional_flows_type.zig").AdvancedSecurityAdditionalFlowsType;
const AdvancedSecurityModeType = @import("advanced_security_mode_type.zig").AdvancedSecurityModeType;

/// Contains settings for activation of threat protection, including the
/// operating
/// mode and additional authentication types. To log user security information
/// but take
/// no action, set to `AUDIT`. To configure automatic security responses to
/// potentially unwanted traffic to your user pool, set to `ENFORCED`.
///
/// For more information, see [Adding advanced security to a user
/// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-advanced-security.html). To activate this setting, your user pool must be on the [
/// Plus
/// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-plus.html).
pub const UserPoolAddOnsType = struct {
    /// Threat protection configuration options for additional authentication types
    /// in your
    /// user pool, including custom
    /// authentication.
    advanced_security_additional_flows: ?AdvancedSecurityAdditionalFlowsType = null,

    /// The operating mode of threat protection for standard authentication types in
    /// your user
    /// pool, including username-password and secure remote password (SRP)
    /// authentication.
    advanced_security_mode: AdvancedSecurityModeType,

    pub const json_field_names = .{
        .advanced_security_additional_flows = "AdvancedSecurityAdditionalFlows",
        .advanced_security_mode = "AdvancedSecurityMode",
    };
};
