pub const AlarmModelVersionStatus = enum {
    active,
    activating,
    inactive,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .activating = "ACTIVATING",
        .inactive = "INACTIVE",
        .failed = "FAILED",
    };
};
