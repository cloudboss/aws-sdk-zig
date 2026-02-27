/// The communication limit time unit.
pub const CommunicationLimitTimeUnit = enum {
    day,

    pub const json_field_names = .{
        .day = "DAY",
    };
};
