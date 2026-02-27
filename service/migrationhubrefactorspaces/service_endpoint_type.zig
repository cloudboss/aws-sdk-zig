pub const ServiceEndpointType = enum {
    lambda,
    url,

    pub const json_field_names = .{
        .lambda = "LAMBDA",
        .url = "URL",
    };
};
