const std = @import("std");

pub const InstalledComponentLifecycleState = enum {
    new,
    installed,
    starting,
    running,
    stopping,
    errored,
    broken,
    finished,

    pub const json_field_names = .{
        .new = "NEW",
        .installed = "INSTALLED",
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .errored = "ERRORED",
        .broken = "BROKEN",
        .finished = "FINISHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new => "NEW",
            .installed => "INSTALLED",
            .starting => "STARTING",
            .running => "RUNNING",
            .stopping => "STOPPING",
            .errored => "ERRORED",
            .broken => "BROKEN",
            .finished => "FINISHED",
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
