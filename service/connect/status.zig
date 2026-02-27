pub const Status = enum {
    complete,
    in_progress,
    deleted,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .in_progress = "IN_PROGRESS",
        .deleted = "DELETED",
    };
};
