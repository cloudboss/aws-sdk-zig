pub const GenerationStatus = enum {
    failed,
    complete,
    in_progress,

    pub const json_field_names = .{
        .failed = "Failed",
        .complete = "Complete",
        .in_progress = "InProgress",
    };
};
