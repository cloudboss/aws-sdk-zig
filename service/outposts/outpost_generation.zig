const std = @import("std");

pub const OutpostGeneration = enum {
    generation_2,
    generation_1,

    pub const json_field_names = .{
        .generation_2 = "GENERATION_2",
        .generation_1 = "GENERATION_1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .generation_2 => "GENERATION_2",
            .generation_1 => "GENERATION_1",
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
