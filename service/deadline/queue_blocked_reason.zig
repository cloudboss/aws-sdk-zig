const std = @import("std");

pub const QueueBlockedReason = enum {
    no_budget_configured,
    budget_threshold_reached,

    pub const json_field_names = .{
        .no_budget_configured = "NO_BUDGET_CONFIGURED",
        .budget_threshold_reached = "BUDGET_THRESHOLD_REACHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_budget_configured => "NO_BUDGET_CONFIGURED",
            .budget_threshold_reached => "BUDGET_THRESHOLD_REACHED",
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
