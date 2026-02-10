/// Details for Site-to-Site VPN tunnel endpoint maintenance events.
pub const MaintenanceDetails = struct {
    /// Timestamp of last applied maintenance.
    last_maintenance_applied: ?i64,

    /// The timestamp after which Amazon Web Services will automatically apply
    /// maintenance.
    maintenance_auto_applied_after: ?i64,

    /// Verify existence of a pending maintenance.
    pending_maintenance: ?[]const u8,
};
