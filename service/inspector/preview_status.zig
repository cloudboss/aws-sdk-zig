pub const PreviewStatus = enum {
    work_in_progress,
    completed,

    pub const json_field_names = .{
        .work_in_progress = "WORK_IN_PROGRESS",
        .completed = "COMPLETED",
    };
};
