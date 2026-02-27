/// The endpoint type. The valid values are `EDGE` for edge-optimized API setup,
/// most suitable for mobile applications; `REGIONAL` for regional API endpoint
/// setup, most suitable for calling from AWS Region; and `PRIVATE` for private
/// APIs.
pub const EndpointType = enum {
    regional,
    edge,
    private,

    pub const json_field_names = .{
        .regional = "REGIONAL",
        .edge = "EDGE",
        .private = "PRIVATE",
    };
};
