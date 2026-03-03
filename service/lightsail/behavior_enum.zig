const std = @import("std");

pub const BehaviorEnum = enum {
    dont_cache_setting,
    cache_setting,

    pub const json_field_names = .{
        .dont_cache_setting = "dont-cache",
        .cache_setting = "cache",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dont_cache_setting => "dont-cache",
            .cache_setting => "cache",
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
