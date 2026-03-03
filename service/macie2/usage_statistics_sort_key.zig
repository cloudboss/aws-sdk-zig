const std = @import("std");

/// The field to use to sort the results of a query for Amazon Macie account
/// quotas and usage data. Valid values are:
pub const UsageStatisticsSortKey = enum {
    account_id,
    total,
    service_limit_value,
    free_trial_start_date,

    pub const json_field_names = .{
        .account_id = "accountId",
        .total = "total",
        .service_limit_value = "serviceLimitValue",
        .free_trial_start_date = "freeTrialStartDate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "accountId",
            .total => "total",
            .service_limit_value => "serviceLimitValue",
            .free_trial_start_date => "freeTrialStartDate",
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
