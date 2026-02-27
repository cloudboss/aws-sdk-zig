pub const ThroughputMode = enum {
    bursting,
    provisioned,
    elastic,

    pub const json_field_names = .{
        .bursting = "BURSTING",
        .provisioned = "PROVISIONED",
        .elastic = "ELASTIC",
    };
};
