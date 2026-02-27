pub const CancellationStatus = enum {
    cancelling,
    cancelled,

    pub const json_field_names = .{
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
    };
};
