const std = @import("std");

pub const PrivacyBudgetType = enum {
    differential_privacy,
    access_budget,

    pub const json_field_names = .{
        .differential_privacy = "DIFFERENTIAL_PRIVACY",
        .access_budget = "ACCESS_BUDGET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .differential_privacy => "DIFFERENTIAL_PRIVACY",
            .access_budget => "ACCESS_BUDGET",
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
