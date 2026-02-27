pub const LagState = enum {
    requested,
    pending,
    available,
    down,
    deleting,
    deleted,
    unknown,

    pub const json_field_names = .{
        .requested = "requested",
        .pending = "pending",
        .available = "available",
        .down = "down",
        .deleting = "deleting",
        .deleted = "deleted",
        .unknown = "unknown",
    };
};
