pub const HECEndpointType = enum {
    raw,
    event,

    pub const json_field_names = .{
        .raw = "Raw",
        .event = "Event",
    };
};
