const std = @import("std");

pub const LambdaFunctionTimeoutType = enum {
    start_to_close,

    pub const json_field_names = .{
        .start_to_close = "START_TO_CLOSE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_to_close => "START_TO_CLOSE",
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
