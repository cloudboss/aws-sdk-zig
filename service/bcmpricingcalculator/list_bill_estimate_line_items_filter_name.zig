pub const ListBillEstimateLineItemsFilterName = enum {
    usage_account_id,
    service_code,
    usage_type,
    operation,
    location,
    line_item_type,

    pub const json_field_names = .{
        .usage_account_id = "USAGE_ACCOUNT_ID",
        .service_code = "SERVICE_CODE",
        .usage_type = "USAGE_TYPE",
        .operation = "OPERATION",
        .location = "LOCATION",
        .line_item_type = "LINE_ITEM_TYPE",
    };
};
