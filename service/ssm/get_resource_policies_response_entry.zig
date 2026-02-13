/// A resource policy helps you to define the IAM entity (for example, an
/// Amazon Web Services account) that can manage your Systems Manager resources.
/// Currently, `OpsItemGroup` is the
/// only resource that supports Systems Manager resource policies. The resource
/// policy for
/// `OpsItemGroup` enables Amazon Web Services accounts to view and interact
/// with OpsCenter operational
/// work items (OpsItems).
pub const GetResourcePoliciesResponseEntry = struct {
    /// A resource policy helps you to define the IAM entity (for example, an
    /// Amazon Web Services account) that can manage your Systems Manager resources.
    /// Currently, `OpsItemGroup` is the
    /// only resource that supports Systems Manager resource policies. The resource
    /// policy for
    /// `OpsItemGroup` enables Amazon Web Services accounts to view and interact
    /// with OpsCenter operational
    /// work items (OpsItems).
    policy: ?[]const u8,

    /// ID of the current policy version. The hash helps to prevent a situation
    /// where multiple users
    /// attempt to overwrite a policy. You must provide this hash when updating or
    /// deleting a
    /// policy.
    policy_hash: ?[]const u8,

    /// A policy ID.
    policy_id: ?[]const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .policy_hash = "PolicyHash",
        .policy_id = "PolicyId",
    };
};
