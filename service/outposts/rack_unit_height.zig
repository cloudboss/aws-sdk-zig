const std = @import("std");

pub const RackUnitHeight = enum {
    height_42_u,
    height_2_u,
    height_1_u,

    pub const json_field_names = .{
        .height_42_u = "HEIGHT_42U",
        .height_2_u = "HEIGHT_2U",
        .height_1_u = "HEIGHT_1U",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .height_42_u => "HEIGHT_42U",
            .height_2_u => "HEIGHT_2U",
            .height_1_u => "HEIGHT_1U",
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
