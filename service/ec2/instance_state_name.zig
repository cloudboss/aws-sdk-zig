const std = @import("std");

pub const InstanceStateName = enum {
    pending,
    running,
    shutting_down,
    terminated,
    stopping,
    stopped,

    pub const json_field_names = .{
        .pending = "pending",
        .running = "running",
        .shutting_down = "shutting-down",
        .terminated = "terminated",
        .stopping = "stopping",
        .stopped = "stopped",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .running => "running",
            .shutting_down => "shutting-down",
            .terminated => "terminated",
            .stopping => "stopping",
            .stopped => "stopped",
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
