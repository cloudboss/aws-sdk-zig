const std = @import("std");

pub const EcrPullDateRescanMode = enum {
    last_pull_date,
    last_in_use_at,

    pub const json_field_names = .{
        .last_pull_date = "LAST_PULL_DATE",
        .last_in_use_at = "LAST_IN_USE_AT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .last_pull_date => "LAST_PULL_DATE",
            .last_in_use_at => "LAST_IN_USE_AT",
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
