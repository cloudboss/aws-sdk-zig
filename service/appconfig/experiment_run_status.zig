const std = @import("std");

pub const ExperimentRunStatus = enum {
    running,
    done,

    pub const json_field_names = .{
        .running = "RUNNING",
        .done = "DONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "RUNNING",
            .done => "DONE",
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
