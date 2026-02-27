pub const WaypointOptimizationConstraint = enum {
    access_hours,
    appointment_time,
    before,
    heading,
    service_duration,
    side_of_street,

    pub const json_field_names = .{
        .access_hours = "ACCESS_HOURS",
        .appointment_time = "APPOINTMENT_TIME",
        .before = "BEFORE",
        .heading = "HEADING",
        .service_duration = "SERVICE_DURATION",
        .side_of_street = "SIDE_OF_STREET",
    };
};
