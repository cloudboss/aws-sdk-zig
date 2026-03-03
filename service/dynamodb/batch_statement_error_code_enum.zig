const std = @import("std");

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

    pub const json_field_names = .{
        .conditional_check_failed = "ConditionalCheckFailed",
        .item_collection_size_limit_exceeded = "ItemCollectionSizeLimitExceeded",
        .request_limit_exceeded = "RequestLimitExceeded",
        .validation_error = "ValidationError",
        .provisioned_throughput_exceeded = "ProvisionedThroughputExceeded",
        .transaction_conflict = "TransactionConflict",
        .throttling_error = "ThrottlingError",
        .internal_server_error = "InternalServerError",
        .resource_not_found = "ResourceNotFound",
        .access_denied = "AccessDenied",
        .duplicate_item = "DuplicateItem",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .conditional_check_failed => "ConditionalCheckFailed",
            .item_collection_size_limit_exceeded => "ItemCollectionSizeLimitExceeded",
            .request_limit_exceeded => "RequestLimitExceeded",
            .validation_error => "ValidationError",
            .provisioned_throughput_exceeded => "ProvisionedThroughputExceeded",
            .transaction_conflict => "TransactionConflict",
            .throttling_error => "ThrottlingError",
            .internal_server_error => "InternalServerError",
            .resource_not_found => "ResourceNotFound",
            .access_denied => "AccessDenied",
            .duplicate_item => "DuplicateItem",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
