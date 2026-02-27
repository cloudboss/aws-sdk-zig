pub const OverrideDays = enum {
    sunday,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,

    pub const json_field_names = .{
        .sunday = "SUNDAY",
        .monday = "MONDAY",
        .tuesday = "TUESDAY",
        .wednesday = "WEDNESDAY",
        .thursday = "THURSDAY",
        .friday = "FRIDAY",
        .saturday = "SATURDAY",
    };
};
