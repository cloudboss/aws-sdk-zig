pub const ExportImageTaskState = enum {
    exporting,
    completed,
    failed,

    pub const json_field_names = .{
        .exporting = "EXPORTING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
