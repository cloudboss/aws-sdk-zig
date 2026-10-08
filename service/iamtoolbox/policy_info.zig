const AttachedTo = @import("attached_to.zig").AttachedTo;
const PolicyType = @import("policy_type.zig").PolicyType;

/// Contains details about a policy evaluated during authorization. Details
/// include the policy type, whether it is inline or managed, a URI that
/// identifies it, and the entities it is attached to.
pub const PolicyInfo = struct {
    /// The entities that the policy is attached to. For identity, session, and
    /// resource-based policies, this is typically a single entity. For organization
    /// control policies (SCPs and RCPs), it can be multiple entities at different
    /// levels of the organization hierarchy.
    attached_to: ?[]const AttachedTo = null,

    /// Specifies whether this is an inline policy (`true`) or a managed policy
    /// (`false`).
    @"inline": ?bool = null,

    /// The type of policy. Valid values:
    ///
    /// * `IDENTITY_BASED_POLICY` - An identity-based policy attached to an IAM
    ///   user, group, or role.
    /// * `PERMISSIONS_BOUNDARY` - A permissions boundary for an IAM entity.
    /// * `RESOURCE_BASED_POLICY` - A resource-based policy attached to a resource.
    /// * `RESOURCE_CONTROL_POLICY` - A resource control policy (RCP) in AWS
    ///   Organizations.
    /// * `SERVICE_CONTROL_POLICY` - A service control policy (SCP) in AWS
    ///   Organizations.
    /// * `SESSION_POLICY` - A session policy passed during role assumption or
    ///   federation.
    /// * `VPC_ENDPOINT_POLICY` - A VPC endpoint policy.
    type: ?PolicyType = null,

    /// A URI that identifies the policy. Use this URI to cross-reference the policy
    /// with the matching policies in each evaluation. The value depends on the
    /// policy type:
    ///
    /// * For managed policies, this is the policy ARN.
    /// * For inline policies, which have no ARN, this is an opaque identifier.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .attached_to = "attachedTo",
        .@"inline" = "inline",
        .type = "type",
        .uri = "uri",
    };
};
