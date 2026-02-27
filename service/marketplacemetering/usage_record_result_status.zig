pub const UsageRecordResultStatus = enum {
    success,
    customer_not_subscribed,
    duplicate_record,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .customer_not_subscribed = "CUSTOMER_NOT_SUBSCRIBED",
        .duplicate_record = "DUPLICATE_RECORD",
    };
};
