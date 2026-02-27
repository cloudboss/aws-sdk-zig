/// Represents an endpoint type.
pub const EndpointType = enum {
    regional,
    edge,

    pub const json_field_names = .{
        .regional = "REGIONAL",
        .edge = "EDGE",
    };
};
