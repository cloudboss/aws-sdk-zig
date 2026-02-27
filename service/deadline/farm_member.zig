const MembershipLevel = @import("membership_level.zig").MembershipLevel;
const DeadlinePrincipalType = @import("deadline_principal_type.zig").DeadlinePrincipalType;

/// The member of a farm.
pub const FarmMember = struct {
    /// The farm ID of the farm member.
    farm_id: []const u8,

    /// The identity store ID of the farm member.
    identity_store_id: []const u8,

    /// The farm member's membership level.
    membership_level: MembershipLevel,

    /// The principal ID of the farm member.
    principal_id: []const u8,

    /// The principal type of the farm member.
    principal_type: DeadlinePrincipalType,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .identity_store_id = "identityStoreId",
        .membership_level = "membershipLevel",
        .principal_id = "principalId",
        .principal_type = "principalType",
    };
};
