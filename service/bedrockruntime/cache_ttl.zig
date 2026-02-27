/// Time-to-live duration for ephemeral cache entries
pub const CacheTTL = enum {
    five_minutes,
    one_hour,

    pub const json_field_names = .{
        .five_minutes = "FIVE_MINUTES",
        .one_hour = "ONE_HOUR",
    };
};
