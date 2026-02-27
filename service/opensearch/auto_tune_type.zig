/// Specifies the Auto-Tune type. Valid value is SCHEDULED_ACTION.
pub const AutoTuneType = enum {
    scheduled_action,

    pub const json_field_names = .{
        .scheduled_action = "SCHEDULED_ACTION",
    };
};
