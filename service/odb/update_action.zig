const std = @import("std");

pub const UpdateAction = enum {
    rolling_apply,
    non_rolling_apply,
    precheck,
    rollback,

    pub const json_field_names = .{
        .rolling_apply = "ROLLING_APPLY",
        .non_rolling_apply = "NON_ROLLING_APPLY",
        .precheck = "PRECHECK",
        .rollback = "ROLLBACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rolling_apply => "ROLLING_APPLY",
            .non_rolling_apply => "NON_ROLLING_APPLY",
            .precheck => "PRECHECK",
            .rollback => "ROLLBACK",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
