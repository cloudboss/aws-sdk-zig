pub const LastUpdateStatus = enum {
    successful,
    failed,
    in_progress,

    pub const json_field_names = .{
        .successful = "Successful",
        .failed = "Failed",
        .in_progress = "InProgress",
    };
};
