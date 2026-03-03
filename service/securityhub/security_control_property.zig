const std = @import("std");

pub const SecurityControlProperty = enum {
    parameters,

    pub const json_field_names = .{
        .parameters = "Parameters",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .parameters => "Parameters",
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
