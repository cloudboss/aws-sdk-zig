const WafConfig = @import("waf_config.zig").WafConfig;

/// Configuration settings that control a policy's behavior.
pub const PolicyConfiguration = struct {
    /// Specifies whether AWS Network Security Manager automatically remediates
    /// noncompliant resources. Default: `false`.
    remediation_enabled: bool = false,

    /// Specifies whether AWS Network Security Manager automatically removes the
    /// resources it created when they are no longer needed. Default: `false`.
    resources_clean_up: bool = false,

    /// AWS WAF-specific policy settings. This is populated only for AWS WAF
    /// policies.
    waf_config: ?WafConfig = null,

    pub const json_field_names = .{
        .remediation_enabled = "remediationEnabled",
        .resources_clean_up = "resourcesCleanUp",
        .waf_config = "wafConfig",
    };
};
