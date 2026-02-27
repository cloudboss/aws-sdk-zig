pub const LookbackPeriodInDays = enum {
    seven_days,
    thirty_days,
    sixty_days,

    pub const json_field_names = .{
        .seven_days = "SEVEN_DAYS",
        .thirty_days = "THIRTY_DAYS",
        .sixty_days = "SIXTY_DAYS",
    };
};
