pub const ConnectionState = enum {
    ordering,
    requested,
    pending,
    available,
    down,
    deleting,
    deleted,
    rejected,
    unknown,

    pub const json_field_names = .{
        .ordering = "ordering",
        .requested = "requested",
        .pending = "pending",
        .available = "available",
        .down = "down",
        .deleting = "deleting",
        .deleted = "deleted",
        .rejected = "rejected",
        .unknown = "unknown",
    };
};
