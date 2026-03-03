const std = @import("std");

pub const BulkEmailStatus = enum {
    success,
    message_rejected,
    mail_from_domain_not_verified,
    configuration_set_not_found,
    template_not_found,
    account_suspended,
    account_throttled,
    account_daily_quota_exceeded,
    invalid_sending_pool_name,
    account_sending_paused,
    configuration_set_sending_paused,
    invalid_parameter,
    transient_failure,
    failed,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .message_rejected = "MESSAGE_REJECTED",
        .mail_from_domain_not_verified = "MAIL_FROM_DOMAIN_NOT_VERIFIED",
        .configuration_set_not_found = "CONFIGURATION_SET_NOT_FOUND",
        .template_not_found = "TEMPLATE_NOT_FOUND",
        .account_suspended = "ACCOUNT_SUSPENDED",
        .account_throttled = "ACCOUNT_THROTTLED",
        .account_daily_quota_exceeded = "ACCOUNT_DAILY_QUOTA_EXCEEDED",
        .invalid_sending_pool_name = "INVALID_SENDING_POOL_NAME",
        .account_sending_paused = "ACCOUNT_SENDING_PAUSED",
        .configuration_set_sending_paused = "CONFIGURATION_SET_SENDING_PAUSED",
        .invalid_parameter = "INVALID_PARAMETER",
        .transient_failure = "TRANSIENT_FAILURE",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .message_rejected => "MESSAGE_REJECTED",
            .mail_from_domain_not_verified => "MAIL_FROM_DOMAIN_NOT_VERIFIED",
            .configuration_set_not_found => "CONFIGURATION_SET_NOT_FOUND",
            .template_not_found => "TEMPLATE_NOT_FOUND",
            .account_suspended => "ACCOUNT_SUSPENDED",
            .account_throttled => "ACCOUNT_THROTTLED",
            .account_daily_quota_exceeded => "ACCOUNT_DAILY_QUOTA_EXCEEDED",
            .invalid_sending_pool_name => "INVALID_SENDING_POOL_NAME",
            .account_sending_paused => "ACCOUNT_SENDING_PAUSED",
            .configuration_set_sending_paused => "CONFIGURATION_SET_SENDING_PAUSED",
            .invalid_parameter => "INVALID_PARAMETER",
            .transient_failure => "TRANSIENT_FAILURE",
            .failed => "FAILED",
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
