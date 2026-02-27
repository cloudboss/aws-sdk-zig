pub const EventActionability = enum {
    action_required,
    action_may_be_required,
    informational,

    pub const json_field_names = .{
        .action_required = "ACTION_REQUIRED",
        .action_may_be_required = "ACTION_MAY_BE_REQUIRED",
        .informational = "INFORMATIONAL",
    };
};
