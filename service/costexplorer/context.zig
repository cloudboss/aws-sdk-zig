const std = @import("std");

pub const Context = enum {
    cost_and_usage,
    reservations,
    savings_plans,

    pub const json_field_names = .{
        .cost_and_usage = "COST_AND_USAGE",
        .reservations = "RESERVATIONS",
        .savings_plans = "SAVINGS_PLANS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cost_and_usage => "COST_AND_USAGE",
            .reservations => "RESERVATIONS",
            .savings_plans => "SAVINGS_PLANS",
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
