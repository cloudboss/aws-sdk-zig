const std = @import("std");

pub const ExecutionType = enum {
    approve_budget_action,
    retry_budget_action,
    reverse_budget_action,
    reset_budget_action,

    pub const json_field_names = .{
        .approve_budget_action = "APPROVE_BUDGET_ACTION",
        .retry_budget_action = "RETRY_BUDGET_ACTION",
        .reverse_budget_action = "REVERSE_BUDGET_ACTION",
        .reset_budget_action = "RESET_BUDGET_ACTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .approve_budget_action => "APPROVE_BUDGET_ACTION",
            .retry_budget_action => "RETRY_BUDGET_ACTION",
            .reverse_budget_action => "REVERSE_BUDGET_ACTION",
            .reset_budget_action => "RESET_BUDGET_ACTION",
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
