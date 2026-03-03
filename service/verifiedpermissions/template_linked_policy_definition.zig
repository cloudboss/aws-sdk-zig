const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;

/// Contains information about a policy created by instantiating a policy
/// template.
pub const TemplateLinkedPolicyDefinition = struct {
    /// The unique identifier of the policy template used to create this policy.
    policy_template_id: []const u8,

    /// The principal associated with this template-linked policy. Verified
    /// Permissions substitutes this principal for the `?principal` placeholder in
    /// the policy template when it evaluates an authorization request.
    principal: ?EntityIdentifier = null,

    /// The resource associated with this template-linked policy. Verified
    /// Permissions substitutes this resource for the `?resource` placeholder in the
    /// policy template when it evaluates an authorization request.
    resource: ?EntityIdentifier = null,

    pub const json_field_names = .{
        .policy_template_id = "policyTemplateId",
        .principal = "principal",
        .resource = "resource",
    };
};
