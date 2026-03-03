const std = @import("std");

pub const PinBlockLengthPosition = enum {
    none,
    front_of_pin_block,

    pub const json_field_names = .{
        .none = "NONE",
        .front_of_pin_block = "FRONT_OF_PIN_BLOCK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .front_of_pin_block => "FRONT_OF_PIN_BLOCK",
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
