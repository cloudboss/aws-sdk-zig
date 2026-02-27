pub const ServiceUpdateStatus = enum {
    not_applied,
    in_progress,
    complete,
    scheduled,

    pub const json_field_names = .{
        .not_applied = "NOT_APPLIED",
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .scheduled = "SCHEDULED",
    };
};
