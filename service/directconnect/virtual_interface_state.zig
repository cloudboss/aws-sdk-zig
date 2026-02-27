pub const VirtualInterfaceState = enum {
    confirming,
    verifying,
    pending,
    available,
    down,
    testing,
    deleting,
    deleted,
    rejected,
    unknown,

    pub const json_field_names = .{
        .confirming = "confirming",
        .verifying = "verifying",
        .pending = "pending",
        .available = "available",
        .down = "down",
        .testing = "testing",
        .deleting = "deleting",
        .deleted = "deleted",
        .rejected = "rejected",
        .unknown = "unknown",
    };
};
