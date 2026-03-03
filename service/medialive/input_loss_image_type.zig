const std = @import("std");

/// Input Loss Image Type
pub const InputLossImageType = enum {
    color,
    slate,

    pub const json_field_names = .{
        .color = "COLOR",
        .slate = "SLATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .color => "COLOR",
            .slate => "SLATE",
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
