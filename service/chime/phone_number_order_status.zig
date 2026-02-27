pub const PhoneNumberOrderStatus = enum {
    processing,
    successful,
    failed,
    partial,

    pub const json_field_names = .{
        .processing = "Processing",
        .successful = "Successful",
        .failed = "Failed",
        .partial = "Partial",
    };
};
