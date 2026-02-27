pub const AvailabilityMonitorTestStatus = enum {
    complete,
    failed,
    pending,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .failed = "FAILED",
        .pending = "PENDING",
    };
};
