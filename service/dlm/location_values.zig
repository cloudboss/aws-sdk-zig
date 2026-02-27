pub const LocationValues = enum {
    cloud,
    outpost_local,
    local_zone,

    pub const json_field_names = .{
        .cloud = "CLOUD",
        .outpost_local = "OUTPOST_LOCAL",
        .local_zone = "LOCAL_ZONE",
    };
};
