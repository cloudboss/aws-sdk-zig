const std = @import("std");

pub const FailureReasonCode = enum {
    invalid_attribute_key,
    invalid_customer_endpoint,
    invalid_system_endpoint,
    invalid_queue,
    invalid_outbound_strategy,
    missing_campaign,
    missing_customer_endpoint,
    missing_queue_id_and_system_endpoint,
    request_throttled,
    idempotency_exception,
    internal_error,

    pub const json_field_names = .{
        .invalid_attribute_key = "INVALID_ATTRIBUTE_KEY",
        .invalid_customer_endpoint = "INVALID_CUSTOMER_ENDPOINT",
        .invalid_system_endpoint = "INVALID_SYSTEM_ENDPOINT",
        .invalid_queue = "INVALID_QUEUE",
        .invalid_outbound_strategy = "INVALID_OUTBOUND_STRATEGY",
        .missing_campaign = "MISSING_CAMPAIGN",
        .missing_customer_endpoint = "MISSING_CUSTOMER_ENDPOINT",
        .missing_queue_id_and_system_endpoint = "MISSING_QUEUE_ID_AND_SYSTEM_ENDPOINT",
        .request_throttled = "REQUEST_THROTTLED",
        .idempotency_exception = "IDEMPOTENCY_EXCEPTION",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_attribute_key => "INVALID_ATTRIBUTE_KEY",
            .invalid_customer_endpoint => "INVALID_CUSTOMER_ENDPOINT",
            .invalid_system_endpoint => "INVALID_SYSTEM_ENDPOINT",
            .invalid_queue => "INVALID_QUEUE",
            .invalid_outbound_strategy => "INVALID_OUTBOUND_STRATEGY",
            .missing_campaign => "MISSING_CAMPAIGN",
            .missing_customer_endpoint => "MISSING_CUSTOMER_ENDPOINT",
            .missing_queue_id_and_system_endpoint => "MISSING_QUEUE_ID_AND_SYSTEM_ENDPOINT",
            .request_throttled => "REQUEST_THROTTLED",
            .idempotency_exception => "IDEMPOTENCY_EXCEPTION",
            .internal_error => "INTERNAL_ERROR",
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
