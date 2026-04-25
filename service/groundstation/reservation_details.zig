const ContactReservationDetails = @import("contact_reservation_details.zig").ContactReservationDetails;
const MaintenanceReservationDetails = @import("maintenance_reservation_details.zig").MaintenanceReservationDetails;

/// Details of a ground station reservation.
pub const ReservationDetails = union(enum) {
    /// Details of a contact reservation.
    contact: ?ContactReservationDetails,
    /// Details of a maintenance reservation.
    maintenance: ?MaintenanceReservationDetails,

    pub const json_field_names = .{
        .contact = "contact",
        .maintenance = "maintenance",
    };
};
