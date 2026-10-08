const WAFConflictResolutionOptions = @import("waf_conflict_resolution_options.zig").WAFConflictResolutionOptions;
const ExistingCustomerWebACLResolution = @import("existing_customer_web_acl_resolution.zig").ExistingCustomerWebACLResolution;

/// AWS WAF-specific policy configuration settings.
pub const WafConfig = struct {
    /// The conflict-resolution strategy for AWS WAF policies. Required for AWS WAF
    /// policies.
    conflict_resolution: WAFConflictResolutionOptions,

    /// Determines how AWS Network Security Manager handles remediation when a
    /// resource already has a customer-created web ACL. Required for AWS WAF
    /// policies.
    existing_customer_web_acl_resolution: ExistingCustomerWebACLResolution,

    pub const json_field_names = .{
        .conflict_resolution = "conflictResolution",
        .existing_customer_web_acl_resolution = "existingCustomerWebACLResolution",
    };
};
