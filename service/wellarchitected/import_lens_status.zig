pub const ImportLensStatus = enum {
    in_progress,
    complete,
    @"error",

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .@"error" = "ERROR",
    };
};
