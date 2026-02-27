pub const MaintenanceDay = enum {
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,

    pub const json_field_names = .{
        .monday = "Monday",
        .tuesday = "Tuesday",
        .wednesday = "Wednesday",
        .thursday = "Thursday",
        .friday = "Friday",
        .saturday = "Saturday",
        .sunday = "Sunday",
    };
};
