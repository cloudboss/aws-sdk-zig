const WaypointOptimizationAccessHours = @import("waypoint_optimization_access_hours.zig").WaypointOptimizationAccessHours;
const WaypointOptimizationSideOfStreetOptions = @import("waypoint_optimization_side_of_street_options.zig").WaypointOptimizationSideOfStreetOptions;

/// Waypoint between the Origin and Destination.
pub const WaypointOptimizationWaypoint = struct {
    /// Access hours corresponding to when a waypoint can be visited.
    access_hours: ?WaypointOptimizationAccessHours = null,

    /// Appointment time at the waypoint.
    appointment_time: ?[]const u8 = null,

    /// Constraint defining what waypoints are to be visited after this waypoint.
    before: ?[]const i32 = null,

    /// GPS Heading at the position.
    heading: f64 = 0,

    /// The waypoint Id.
    id: ?[]const u8 = null,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    /// Service time spent at the waypoint. At an appointment, the service time
    /// should be the appointment duration.
    ///
    /// **Unit**: `seconds`
    service_duration: i64 = 0,

    /// Options to configure matching the provided position to a side of the street.
    side_of_street: ?WaypointOptimizationSideOfStreetOptions = null,

    pub const json_field_names = .{
        .access_hours = "AccessHours",
        .appointment_time = "AppointmentTime",
        .before = "Before",
        .heading = "Heading",
        .id = "Id",
        .position = "Position",
        .service_duration = "ServiceDuration",
        .side_of_street = "SideOfStreet",
    };
};
