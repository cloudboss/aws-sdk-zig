const std = @import("std");

pub const WorkerComputeType = enum {
    cr1_x,
    cr4_x,

    pub const json_field_names = .{
        .cr1_x = "CR.1X",
        .cr4_x = "CR.4X",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cr1_x => "CR.1X",
            .cr4_x => "CR.4X",
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
