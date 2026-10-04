const std = @import("std");

pub const WorkerComputeType = enum {
    cr1_x,
    cr4_x,
    cr8_x,

    pub const json_field_names = .{
        .cr1_x = "CR.1X",
        .cr4_x = "CR.4X",
        .cr8_x = "CR.8X",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cr1_x => "CR.1X",
            .cr4_x => "CR.4X",
            .cr8_x => "CR.8X",
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
