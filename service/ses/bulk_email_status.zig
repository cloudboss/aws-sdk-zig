const std = @import("std");

pub const BulkEmailStatus = enum {
    success,
    message_rejected,
    mail_from_domain_not_verified,
    configuration_set_does_not_exist,
    template_does_not_exist,
    account_suspended,
    account_throttled,
    account_daily_quota_exceeded,
    invalid_sending_pool_name,
    account_sending_paused,
    configuration_set_sending_paused,
    invalid_parameter_value,
    transient_failure,
    failed,

    pub const json_field_names = .{
        .success = "Success",
        .message_rejected = "MessageRejected",
        .mail_from_domain_not_verified = "MailFromDomainNotVerified",
        .configuration_set_does_not_exist = "ConfigurationSetDoesNotExist",
        .template_does_not_exist = "TemplateDoesNotExist",
        .account_suspended = "AccountSuspended",
        .account_throttled = "AccountThrottled",
        .account_daily_quota_exceeded = "AccountDailyQuotaExceeded",
        .invalid_sending_pool_name = "InvalidSendingPoolName",
        .account_sending_paused = "AccountSendingPaused",
        .configuration_set_sending_paused = "ConfigurationSetSendingPaused",
        .invalid_parameter_value = "InvalidParameterValue",
        .transient_failure = "TransientFailure",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "Success",
            .message_rejected => "MessageRejected",
            .mail_from_domain_not_verified => "MailFromDomainNotVerified",
            .configuration_set_does_not_exist => "ConfigurationSetDoesNotExist",
            .template_does_not_exist => "TemplateDoesNotExist",
            .account_suspended => "AccountSuspended",
            .account_throttled => "AccountThrottled",
            .account_daily_quota_exceeded => "AccountDailyQuotaExceeded",
            .invalid_sending_pool_name => "InvalidSendingPoolName",
            .account_sending_paused => "AccountSendingPaused",
            .configuration_set_sending_paused => "ConfigurationSetSendingPaused",
            .invalid_parameter_value => "InvalidParameterValue",
            .transient_failure => "TransientFailure",
            .failed => "Failed",
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
