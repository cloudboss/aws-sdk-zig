pub const OrderedPhoneNumberStatus = enum {
    processing,
    acquired,
    failed,

    pub const json_field_names = .{
        .processing = "Processing",
        .acquired = "Acquired",
        .failed = "Failed",
    };
};
