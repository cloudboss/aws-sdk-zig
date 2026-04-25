const MaintenanceType = @import("maintenance_type.zig").MaintenanceType;

/// Details of a maintenance reservation.
pub const MaintenanceReservationDetails = struct {
    /// Type of maintenance.
    maintenance_type: MaintenanceType,

    pub const json_field_names = .{
        .maintenance_type = "maintenanceType",
    };
};
