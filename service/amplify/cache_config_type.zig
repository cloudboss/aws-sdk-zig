const std = @import("std");

pub const CacheConfigType = enum {
    amplify_managed,
    amplify_managed_no_cookies,

    pub const json_field_names = .{
        .amplify_managed = "AMPLIFY_MANAGED",
        .amplify_managed_no_cookies = "AMPLIFY_MANAGED_NO_COOKIES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amplify_managed => "AMPLIFY_MANAGED",
            .amplify_managed_no_cookies => "AMPLIFY_MANAGED_NO_COOKIES",
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
