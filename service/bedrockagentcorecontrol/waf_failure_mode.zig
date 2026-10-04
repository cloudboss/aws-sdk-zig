const std = @import("std");

pub const WafFailureMode = enum {
    fail_close,
    fail_open,

    pub const json_field_names = .{
        .fail_close = "FAIL_CLOSE",
        .fail_open = "FAIL_OPEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fail_close => "FAIL_CLOSE",
            .fail_open => "FAIL_OPEN",
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
