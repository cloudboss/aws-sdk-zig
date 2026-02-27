pub const SoftwareSetUpdateStatus = enum {
    available,
    in_progress,
    up_to_date,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .in_progress = "IN_PROGRESS",
        .up_to_date = "UP_TO_DATE",
    };
};
