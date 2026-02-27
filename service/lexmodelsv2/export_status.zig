pub const ExportStatus = enum {
    in_progress,
    completed,
    failed,
    deleting,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .completed = "Completed",
        .failed = "Failed",
        .deleting = "Deleting",
    };
};
