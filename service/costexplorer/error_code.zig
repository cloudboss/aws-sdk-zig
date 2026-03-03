const std = @import("std");

pub const ErrorCode = enum {
    no_usage_found,
    internal_failure,
    invalid_savings_plans_to_add,
    invalid_savings_plans_to_exclude,
    invalid_account_id,

    pub const json_field_names = .{
        .no_usage_found = "NO_USAGE_FOUND",
        .internal_failure = "INTERNAL_FAILURE",
        .invalid_savings_plans_to_add = "INVALID_SAVINGS_PLANS_TO_ADD",
        .invalid_savings_plans_to_exclude = "INVALID_SAVINGS_PLANS_TO_EXCLUDE",
        .invalid_account_id = "INVALID_ACCOUNT_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_usage_found => "NO_USAGE_FOUND",
            .internal_failure => "INTERNAL_FAILURE",
            .invalid_savings_plans_to_add => "INVALID_SAVINGS_PLANS_TO_ADD",
            .invalid_savings_plans_to_exclude => "INVALID_SAVINGS_PLANS_TO_EXCLUDE",
            .invalid_account_id => "INVALID_ACCOUNT_ID",
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
