pub const EndpointType = enum {
    lambda,

    pub const json_field_names = .{
        .lambda = "LAMBDA",
    };
};
