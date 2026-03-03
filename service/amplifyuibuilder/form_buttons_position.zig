const std = @import("std");

pub const FormButtonsPosition = enum {
    top,
    bottom,
    top_and_bottom,

    pub const json_field_names = .{
        .top = "top",
        .bottom = "bottom",
        .top_and_bottom = "top_and_bottom",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .top => "top",
            .bottom => "bottom",
            .top_and_bottom => "top_and_bottom",
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
