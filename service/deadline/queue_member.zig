const MembershipLevel = @import("membership_level.zig").MembershipLevel;
const DeadlinePrincipalType = @import("deadline_principal_type.zig").DeadlinePrincipalType;

/// The details of a queue member.
pub const QueueMember = struct {
    /// The farm ID.
    farm_id: []const u8,

    /// The identity store ID.
    identity_store_id: []const u8,

    /// The queue member's membership level.
    membership_level: MembershipLevel,

    /// The principal ID of the queue member.
    principal_id: []const u8,

    /// The principal type of the queue member.
    principal_type: DeadlinePrincipalType,

    /// The queue ID.
    queue_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .identity_store_id = "identityStoreId",
        .membership_level = "membershipLevel",
        .principal_id = "principalId",
        .principal_type = "principalType",
        .queue_id = "queueId",
    };
};
