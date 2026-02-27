const MembershipLevel = @import("membership_level.zig").MembershipLevel;
const DeadlinePrincipalType = @import("deadline_principal_type.zig").DeadlinePrincipalType;

/// The fleet member.
pub const FleetMember = struct {
    /// The farm ID.
    farm_id: []const u8,

    /// The fleet ID.
    fleet_id: []const u8,

    /// The identity store ID.
    identity_store_id: []const u8,

    /// The fleet member's membership level.
    membership_level: MembershipLevel,

    /// The principal ID of the fleet member.
    principal_id: []const u8,

    /// The principal type of the fleet member.
    principal_type: DeadlinePrincipalType,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .identity_store_id = "identityStoreId",
        .membership_level = "membershipLevel",
        .principal_id = "principalId",
        .principal_type = "principalType",
    };
};
