pub const BatchStatementErrorCodeEnum = enum {
    conditional_check_failed,
    item_collection_size_limit_exceeded,
    request_limit_exceeded,
    validation_error,
    provisioned_throughput_exceeded,
    transaction_conflict,
    throttling_error,
    internal_server_error,
    resource_not_found,
    access_denied,
    duplicate_item,
};
