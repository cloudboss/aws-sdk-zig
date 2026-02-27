pub const PriorityType = enum {
    latency,
    cost,
    destination,
    location,

    pub const json_field_names = .{
        .latency = "LATENCY",
        .cost = "COST",
        .destination = "DESTINATION",
        .location = "LOCATION",
    };
};
