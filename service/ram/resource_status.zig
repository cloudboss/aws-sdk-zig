pub const ResourceStatus = enum {
    available,
    zonal_resource_inaccessible,
    limit_exceeded,
    unavailable,
    pending,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .zonal_resource_inaccessible = "ZONAL_RESOURCE_INACCESSIBLE",
        .limit_exceeded = "LIMIT_EXCEEDED",
        .unavailable = "UNAVAILABLE",
        .pending = "PENDING",
    };
};
