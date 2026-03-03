const std = @import("std");

pub const InstanceType = enum {
    blue,
    green,

    pub const json_field_names = .{
        .blue = "Blue",
        .green = "Green",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .blue => "Blue",
            .green => "Green",
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
