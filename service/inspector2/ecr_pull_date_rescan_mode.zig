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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
