pub const DayOfWeekName = enum {
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,

    pub const json_field_names = .{
        .monday = "MONDAY",
        .tuesday = "TUESDAY",
        .wednesday = "WEDNESDAY",
        .thursday = "THURSDAY",
        .friday = "FRIDAY",
        .saturday = "SATURDAY",
        .sunday = "SUNDAY",
    };
};
