const std = @import("std");

pub const ContributorInsightsMode = enum {
    accessed_and_throttled_keys,
    throttled_keys,

    pub const json_field_names = .{
        .accessed_and_throttled_keys = "ACCESSED_AND_THROTTLED_KEYS",
        .throttled_keys = "THROTTLED_KEYS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accessed_and_throttled_keys => "ACCESSED_AND_THROTTLED_KEYS",
            .throttled_keys => "THROTTLED_KEYS",
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
