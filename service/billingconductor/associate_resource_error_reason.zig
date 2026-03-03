const std = @import("std");

pub const AssociateResourceErrorReason = enum {
    invalid_arn,
    service_limit_exceeded,
    illegal_customlineitem,
    internal_server_exception,
    invalid_billing_period_range,

    pub const json_field_names = .{
        .invalid_arn = "INVALID_ARN",
        .service_limit_exceeded = "SERVICE_LIMIT_EXCEEDED",
        .illegal_customlineitem = "ILLEGAL_CUSTOMLINEITEM",
        .internal_server_exception = "INTERNAL_SERVER_EXCEPTION",
        .invalid_billing_period_range = "INVALID_BILLING_PERIOD_RANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_arn => "INVALID_ARN",
            .service_limit_exceeded => "SERVICE_LIMIT_EXCEEDED",
            .illegal_customlineitem => "ILLEGAL_CUSTOMLINEITEM",
            .internal_server_exception => "INTERNAL_SERVER_EXCEPTION",
            .invalid_billing_period_range => "INVALID_BILLING_PERIOD_RANGE",
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
