pub const InvalidRequestReason = enum {
    invalid_document,

    pub const json_field_names = .{
        .invalid_document = "INVALID_DOCUMENT",
    };
};
