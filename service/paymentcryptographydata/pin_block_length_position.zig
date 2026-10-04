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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
