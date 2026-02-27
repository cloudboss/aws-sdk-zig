pub const InternetEventType = enum {
    availability,
    performance,

    pub const json_field_names = .{
        .availability = "AVAILABILITY",
        .performance = "PERFORMANCE",
    };
};
