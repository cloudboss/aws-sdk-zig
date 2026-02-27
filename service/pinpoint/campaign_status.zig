pub const CampaignStatus = enum {
    scheduled,
    executing,
    pending_next_run,
    completed,
    paused,
    deleted,
    invalid,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .executing = "EXECUTING",
        .pending_next_run = "PENDING_NEXT_RUN",
        .completed = "COMPLETED",
        .paused = "PAUSED",
        .deleted = "DELETED",
        .invalid = "INVALID",
    };
};
