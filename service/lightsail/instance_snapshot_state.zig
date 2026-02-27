pub const InstanceSnapshotState = enum {
    pending,
    @"error",
    available,

    pub const json_field_names = .{
        .pending = "Pending",
        .@"error" = "Error",
        .available = "Available",
    };
};
