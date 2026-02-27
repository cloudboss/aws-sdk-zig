pub const DiskState = enum {
    pending,
    @"error",
    available,
    in_use,
    unknown,

    pub const json_field_names = .{
        .pending = "Pending",
        .@"error" = "Error",
        .available = "Available",
        .in_use = "InUse",
        .unknown = "Unknown",
    };
};
