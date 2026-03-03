const std = @import("std");

pub const ShareStatus = enum {
    not_shared,
    shared_with_me,
    shared_by_me,

    pub const json_field_names = .{
        .not_shared = "NOT_SHARED",
        .shared_with_me = "SHARED_WITH_ME",
        .shared_by_me = "SHARED_BY_ME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_shared => "NOT_SHARED",
            .shared_with_me => "SHARED_WITH_ME",
            .shared_by_me => "SHARED_BY_ME",
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
