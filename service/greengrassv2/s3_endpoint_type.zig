pub const S3EndpointType = enum {
    regional,
    global,

    pub const json_field_names = .{
        .regional = "REGIONAL",
        .global = "GLOBAL",
    };
};
