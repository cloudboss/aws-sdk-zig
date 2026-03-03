const std = @import("std");

/// The field to use in a condition that filters the results of a query for
/// Amazon Macie account quotas and usage data. Valid values are:
pub const UsageStatisticsFilterKey = enum {
    account_id,
    service_limit,
    free_trial_start_date,
    total,

    pub const json_field_names = .{
        .account_id = "accountId",
        .service_limit = "serviceLimit",
        .free_trial_start_date = "freeTrialStartDate",
        .total = "total",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "accountId",
            .service_limit => "serviceLimit",
            .free_trial_start_date => "freeTrialStartDate",
            .total => "total",
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
