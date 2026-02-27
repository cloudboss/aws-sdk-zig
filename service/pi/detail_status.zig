pub const DetailStatus = enum {
    available,
    processing,
    unavailable,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .processing = "PROCESSING",
        .unavailable = "UNAVAILABLE",
    };
};
