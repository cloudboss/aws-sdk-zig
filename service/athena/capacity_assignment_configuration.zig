const CapacityAssignment = @import("capacity_assignment.zig").CapacityAssignment;

/// Assigns Athena workgroups (and hence their queries) to capacity
/// reservations. A capacity reservation can have only one capacity assignment
/// configuration, but the capacity assignment configuration can be made up of
/// multiple
/// individual assignments. Each assignment specifies how Athena queries can
/// consume capacity from the capacity reservation that their workgroup is
/// mapped to.
pub const CapacityAssignmentConfiguration = struct {
    /// The list of assignments that make up the capacity assignment configuration.
    capacity_assignments: ?[]const CapacityAssignment = null,

    /// The name of the reservation that the capacity assignment configuration is
    /// for.
    capacity_reservation_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_assignments = "CapacityAssignments",
        .capacity_reservation_name = "CapacityReservationName",
    };
};
