const std = @import("std");

pub const UnauthorizedCacheControlHeaderStrategy = enum {
    fail_with_403,
    succeed_with_response_header,
    succeed_without_response_header,

    pub const json_field_names = .{
        .fail_with_403 = "FAIL_WITH_403",
        .succeed_with_response_header = "SUCCEED_WITH_RESPONSE_HEADER",
        .succeed_without_response_header = "SUCCEED_WITHOUT_RESPONSE_HEADER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fail_with_403 => "FAIL_WITH_403",
            .succeed_with_response_header => "SUCCEED_WITH_RESPONSE_HEADER",
            .succeed_without_response_header => "SUCCEED_WITHOUT_RESPONSE_HEADER",
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
