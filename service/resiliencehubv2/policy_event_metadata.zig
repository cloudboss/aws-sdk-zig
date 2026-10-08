const PolicyAttachedToServiceMetadata = @import("policy_attached_to_service_metadata.zig").PolicyAttachedToServiceMetadata;
const PolicyDeletedMetadata = @import("policy_deleted_metadata.zig").PolicyDeletedMetadata;
const PolicyDetachedFromServiceMetadata = @import("policy_detached_from_service_metadata.zig").PolicyDetachedFromServiceMetadata;
const PolicySharingRevokedMetadata = @import("policy_sharing_revoked_metadata.zig").PolicySharingRevokedMetadata;

/// Contains the event-specific metadata for a policy event. Exactly one member
/// is populated, according to the event type.
///
/// * policyAttachedToService — a service started using the policy.
/// * policyDetachedFromService — a service stopped using the policy.
/// * policySharingRevoked — cross-account sharing was disabled for the policy.
/// * policyDeleted — the policy was deleted.
pub const PolicyEventMetadata = union(enum) {
    /// Contains details about the service that started using the policy, such as
    /// the account that owns the service.
    policy_attached_to_service: ?PolicyAttachedToServiceMetadata,
    /// Contains details about a policy that was deleted, including the number of
    /// services that were affected.
    policy_deleted: ?PolicyDeletedMetadata,
    /// Contains details about the service that stopped using the policy, such as
    /// the account that owns the service.
    policy_detached_from_service: ?PolicyDetachedFromServiceMetadata,
    /// Contains details about a policy for which organization sharing was revoked,
    /// including the number of services that were affected.
    policy_sharing_revoked: ?PolicySharingRevokedMetadata,

    pub const json_field_names = .{
        .policy_attached_to_service = "policyAttachedToService",
        .policy_deleted = "policyDeleted",
        .policy_detached_from_service = "policyDetachedFromService",
        .policy_sharing_revoked = "policySharingRevoked",
    };
};
