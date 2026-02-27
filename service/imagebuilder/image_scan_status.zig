pub const ImageScanStatus = enum {
    pending,
    scanning,
    collecting,
    completed,
    abandoned,
    failed,
    timed_out,

    pub const json_field_names = .{
        .pending = "PENDING",
        .scanning = "SCANNING",
        .collecting = "COLLECTING",
        .completed = "COMPLETED",
        .abandoned = "ABANDONED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
    };
};
