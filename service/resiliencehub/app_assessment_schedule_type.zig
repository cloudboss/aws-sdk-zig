pub const AppAssessmentScheduleType = enum {
    disabled,
    daily,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .daily = "DAILY",
    };
};
