const WaypointOptimizationAccessHours = @import("waypoint_optimization_access_hours.zig").WaypointOptimizationAccessHours;
const WaypointOptimizationSideOfStreetOptions = @import("waypoint_optimization_side_of_street_options.zig").WaypointOptimizationSideOfStreetOptions;

/// Destination related options.
pub const WaypointOptimizationDestinationOptions = struct {
    /// Access hours corresponding to when a waypoint can be visited.
    access_hours: ?WaypointOptimizationAccessHours,

    /// Appointment time at the destination.
    appointment_time: ?[]const u8,

    /// GPS Heading at the position.
    heading: f64 = 0,

    /// The waypoint Id.
    id: ?[]const u8,

    /// Service time spent at the destination. At an appointment, the service time
    /// should be the appointment duration.
    ///
    /// **Unit**: `seconds`
    service_duration: i64 = 0,

    /// Options to configure matching the provided position to a side of the street.
    side_of_street: ?WaypointOptimizationSideOfStreetOptions,

    pub const json_field_names = .{
        .access_hours = "AccessHours",
        .appointment_time = "AppointmentTime",
        .heading = "Heading",
        .id = "Id",
        .service_duration = "ServiceDuration",
        .side_of_street = "SideOfStreet",
    };
};
