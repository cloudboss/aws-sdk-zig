pub const RuleBooleanEmailAttribute = enum {
    read_receipt_requested,
    tls,
    tls_wrapped,

    pub const json_field_names = .{
        .read_receipt_requested = "READ_RECEIPT_REQUESTED",
        .tls = "TLS",
        .tls_wrapped = "TLS_WRAPPED",
    };
};
