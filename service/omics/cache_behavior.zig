const std = @import("std");

pub const CacheBehavior = enum {
    cache_on_failure,
    cache_always,

    pub const json_field_names = .{
        .cache_on_failure = "CACHE_ON_FAILURE",
        .cache_always = "CACHE_ALWAYS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cache_on_failure => "CACHE_ON_FAILURE",
            .cache_always => "CACHE_ALWAYS",
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
