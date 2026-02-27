pub const CampaignStatus = enum {
    creating,
    waiting_for_approval,
    running,
    suspended,

    pub const json_field_names = .{
        .creating = "CREATING",
        .waiting_for_approval = "WAITING_FOR_APPROVAL",
        .running = "RUNNING",
        .suspended = "SUSPENDED",
    };
};
