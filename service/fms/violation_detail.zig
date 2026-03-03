const Tag = @import("tag.zig").Tag;
const ResourceViolation = @import("resource_violation.zig").ResourceViolation;

/// Violations for a resource based on the specified Firewall Manager policy and
/// Amazon Web Services account.
pub const ViolationDetail = struct {
    /// The Amazon Web Services account that the violation details were requested
    /// for.
    member_account: []const u8,

    /// The ID of the Firewall Manager policy that the violation details were
    /// requested for.
    policy_id: []const u8,

    /// Brief description for the requested resource.
    resource_description: ?[]const u8 = null,

    /// The resource ID that the violation details were requested for.
    resource_id: []const u8,

    /// The `ResourceTag` objects associated with the resource.
    resource_tags: ?[]const Tag = null,

    /// The resource type that the violation details were requested for.
    resource_type: []const u8,

    /// List of violations for the requested resource.
    resource_violations: []const ResourceViolation,

    pub const json_field_names = .{
        .member_account = "MemberAccount",
        .policy_id = "PolicyId",
        .resource_description = "ResourceDescription",
        .resource_id = "ResourceId",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .resource_violations = "ResourceViolations",
    };
};
