pub const SupportedDataTransferType = enum {
    record,
    file,

    pub const json_field_names = .{
        .record = "RECORD",
        .file = "FILE",
    };
};
