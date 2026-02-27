pub const TrainingPlanStatus = enum {
    pending,
    active,
    scheduled,
    expired,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .scheduled = "SCHEDULED",
        .expired = "EXPIRED",
        .failed = "FAILED",
    };
};
