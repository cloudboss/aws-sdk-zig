const std = @import("std");

pub const RouterOutputType = enum {
    standard,
    mediaconnect_flow,
    medialive_input,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .mediaconnect_flow = "MEDIACONNECT_FLOW",
        .medialive_input = "MEDIALIVE_INPUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .mediaconnect_flow => "MEDIACONNECT_FLOW",
            .medialive_input => "MEDIALIVE_INPUT",
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
