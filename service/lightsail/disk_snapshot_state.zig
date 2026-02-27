pub const DiskSnapshotState = enum {
    pending,
    completed,
    @"error",
    unknown,

    pub const json_field_names = .{
        .pending = "Pending",
        .completed = "Completed",
        .@"error" = "Error",
        .unknown = "Unknown",
    };
};
