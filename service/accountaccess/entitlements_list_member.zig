const EntitlementSummary = @import("entitlement_summary.zig").EntitlementSummary;

/// Contains information about an entitlement in a list result.
pub const EntitlementsListMember = struct {
    /// The date and time when the entitlement was created.
    created_at: i64,

    /// The summary information for the entitlement.
    entitlement: EntitlementSummary,

    /// The unique identifier of the entitlement.
    entitlement_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .entitlement = "entitlement",
        .entitlement_id = "entitlementId",
    };
};
