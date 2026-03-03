const std = @import("std");

pub const ShapeType = enum {
    amd,
    intel,
    intel_flex_x9,
    ampere_flex_a1,

    pub const json_field_names = .{
        .amd = "AMD",
        .intel = "INTEL",
        .intel_flex_x9 = "INTEL_FLEX_X9",
        .ampere_flex_a1 = "AMPERE_FLEX_A1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amd => "AMD",
            .intel => "INTEL",
            .intel_flex_x9 => "INTEL_FLEX_X9",
            .ampere_flex_a1 => "AMPERE_FLEX_A1",
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
