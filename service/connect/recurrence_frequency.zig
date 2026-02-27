pub const RecurrenceFrequency = enum {
    weekly,
    monthly,
    yearly,

    pub const json_field_names = .{
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
        .yearly = "YEARLY",
    };
};
