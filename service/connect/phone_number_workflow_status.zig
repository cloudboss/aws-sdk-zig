pub const PhoneNumberWorkflowStatus = enum {
    claimed,
    in_progress,
    failed,

    pub const json_field_names = .{
        .claimed = "Claimed",
        .in_progress = "InProgress",
        .failed = "Failed",
    };
};
