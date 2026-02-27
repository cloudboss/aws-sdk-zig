pub const TraceSegmentDestinationStatus = enum {
    pending,
    active,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
    };
};
