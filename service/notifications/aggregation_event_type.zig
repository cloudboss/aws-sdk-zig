pub const AggregationEventType = enum {
    aggregate,
    child,
    none,

    pub const json_field_names = .{
        .aggregate = "AGGREGATE",
        .child = "CHILD",
        .none = "NONE",
    };
};
