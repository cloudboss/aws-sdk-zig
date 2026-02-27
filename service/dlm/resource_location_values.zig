pub const ResourceLocationValues = enum {
    cloud,
    outpost,
    local_zone,

    pub const json_field_names = .{
        .cloud = "CLOUD",
        .outpost = "OUTPOST",
        .local_zone = "LOCAL_ZONE",
    };
};
