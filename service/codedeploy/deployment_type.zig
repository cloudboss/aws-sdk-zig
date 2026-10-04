const std = @import("std");

pub const DeploymentType = enum {
    in_place,
    blue_green,

    pub const json_field_names = .{
        .in_place = "IN_PLACE",
        .blue_green = "BLUE_GREEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_place => "IN_PLACE",
            .blue_green => "BLUE_GREEN",
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
