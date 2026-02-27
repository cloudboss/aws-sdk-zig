pub const ReviewStatus = enum {
    pending,
    failed,
    granted,
    denied,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
        .granted = "GRANTED",
        .denied = "DENIED",
    };
};
