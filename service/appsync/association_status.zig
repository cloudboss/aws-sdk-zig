pub const AssociationStatus = enum {
    processing,
    failed,
    success,

    pub const json_field_names = .{
        .processing = "Processing",
        .failed = "Failed",
        .success = "Success",
    };
};
