const std = @import("std");

pub const StatusFlag = enum {
    pending_acceptance,
    pending_customer_action,
    pending_authorization,
    pending_payment_verification,
    pending_support_case,

    pub const json_field_names = .{
        .pending_acceptance = "PENDING_ACCEPTANCE",
        .pending_customer_action = "PENDING_CUSTOMER_ACTION",
        .pending_authorization = "PENDING_AUTHORIZATION",
        .pending_payment_verification = "PENDING_PAYMENT_VERIFICATION",
        .pending_support_case = "PENDING_SUPPORT_CASE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_acceptance => "PENDING_ACCEPTANCE",
            .pending_customer_action => "PENDING_CUSTOMER_ACTION",
            .pending_authorization => "PENDING_AUTHORIZATION",
            .pending_payment_verification => "PENDING_PAYMENT_VERIFICATION",
            .pending_support_case => "PENDING_SUPPORT_CASE",
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
