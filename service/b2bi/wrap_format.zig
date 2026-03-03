const std = @import("std");

pub const WrapFormat = enum {
    segment,
    one_line,
    line_length,

    pub const json_field_names = .{
        .segment = "SEGMENT",
        .one_line = "ONE_LINE",
        .line_length = "LINE_LENGTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .segment => "SEGMENT",
            .one_line => "ONE_LINE",
            .line_length => "LINE_LENGTH",
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
