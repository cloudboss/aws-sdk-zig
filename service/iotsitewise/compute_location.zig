pub const ComputeLocation = enum {
    edge,
    cloud,

    pub const json_field_names = .{
        .edge = "EDGE",
        .cloud = "CLOUD",
    };
};
