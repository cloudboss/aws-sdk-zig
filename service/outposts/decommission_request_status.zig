pub const DecommissionRequestStatus = enum {
    skipped,
    blocked,
    requested,

    pub const json_field_names = .{
        .skipped = "SKIPPED",
        .blocked = "BLOCKED",
        .requested = "REQUESTED",
    };
};
