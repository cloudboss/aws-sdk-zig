pub const UpdateCampaignAction = enum {
    approve,
    @"suspend",
    @"resume",
    update,

    pub const json_field_names = .{
        .approve = "APPROVE",
        .@"suspend" = "SUSPEND",
        .@"resume" = "RESUME",
        .update = "UPDATE",
    };
};
