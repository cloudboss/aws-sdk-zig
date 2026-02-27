pub const AggregationDuration = enum {
    /// Aggregate notifications for long periods of time (12 hours)
    long,
    /// Aggregate notifications for short periods of time (5 mins)
    short,
    /// Do not aggregate notifications sourced from a notification configuration
    none,

    pub const json_field_names = .{
        .long = "LONG",
        .short = "SHORT",
        .none = "NONE",
    };
};
