pub const PhoneNumberOrderStatus = enum {
    processing,
    successful,
    failed,
    partial,
    pending_documents,
    submitted,
    foc,
    change_requested,
    exception,
    cancel_requested,
    cancelled,

    pub const json_field_names = .{
        .processing = "Processing",
        .successful = "Successful",
        .failed = "Failed",
        .partial = "Partial",
        .pending_documents = "PendingDocuments",
        .submitted = "Submitted",
        .foc = "FOC",
        .change_requested = "ChangeRequested",
        .exception = "Exception",
        .cancel_requested = "CancelRequested",
        .cancelled = "Cancelled",
    };
};
