const CustomerPolicyStatus = @import("customer_policy_status.zig").CustomerPolicyStatus;
const SecurityServiceType = @import("security_service_type.zig").SecurityServiceType;

/// Details of the Firewall Manager policy.
pub const PolicySummary = struct {
    /// Indicates whether Firewall Manager should automatically remove protections
    /// from resources that leave the policy scope and clean up resources
    /// that Firewall Manager is managing for accounts when those accounts leave
    /// policy scope. For example, Firewall Manager will disassociate a Firewall
    /// Manager managed web ACL
    /// from a protected customer resource when the customer resource leaves policy
    /// scope.
    ///
    /// By default, Firewall Manager doesn't remove protections or delete Firewall
    /// Manager managed resources.
    ///
    /// This option is not available for Shield Advanced or WAF Classic policies.
    delete_unused_fm_managed_resources: bool = false,

    /// The Amazon Resource Name (ARN) of the specified policy.
    policy_arn: ?[]const u8,

    /// The ID of the specified policy.
    policy_id: ?[]const u8,

    /// The name of the specified policy.
    policy_name: ?[]const u8,

    /// Indicates whether the policy is in or out of an admin's policy or Region
    /// scope.
    ///
    /// * `ACTIVE` - The administrator can manage and delete the policy.
    ///
    /// * `OUT_OF_ADMIN_SCOPE` - The administrator can view the policy, but they
    ///   can't edit or delete the policy. Existing policy protections stay in
    ///   place. Any new resources that come into scope of the policy won't be
    ///   protected.
    policy_status: ?CustomerPolicyStatus,

    /// Indicates if the policy should be automatically applied to new resources.
    remediation_enabled: bool = false,

    /// The type of resource protected by or in scope of the policy. This is in the
    /// format shown
    /// in the [Amazon Web Services Resource Types
    /// Reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html).
    resource_type: ?[]const u8,

    /// The service that the policy is using to protect the resources. This
    /// specifies the type of
    /// policy that is created, either an WAF policy, a Shield Advanced policy, or a
    /// security
    /// group policy.
    security_service_type: ?SecurityServiceType,

    pub const json_field_names = .{
        .delete_unused_fm_managed_resources = "DeleteUnusedFMManagedResources",
        .policy_arn = "PolicyArn",
        .policy_id = "PolicyId",
        .policy_name = "PolicyName",
        .policy_status = "PolicyStatus",
        .remediation_enabled = "RemediationEnabled",
        .resource_type = "ResourceType",
        .security_service_type = "SecurityServiceType",
    };
};
