pub const ErrorCode = enum {
    duplicate_identifier,
    item_does_not_exist,
    internal_error,
    invalid_finding_id,
    invalid_scan_name,

    pub const json_field_names = .{
        .duplicate_identifier = "DUPLICATE_IDENTIFIER",
        .item_does_not_exist = "ITEM_DOES_NOT_EXIST",
        .internal_error = "INTERNAL_ERROR",
        .invalid_finding_id = "INVALID_FINDING_ID",
        .invalid_scan_name = "INVALID_SCAN_NAME",
    };
};
