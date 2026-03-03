const std = @import("std");

pub const EC2InstanceState = enum {
    pending,
    running,
    stopping,
    stopped,
    shutting_down,
    terminated,
    not_found,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .shutting_down = "SHUTTING-DOWN",
        .terminated = "TERMINATED",
        .not_found = "NOT_FOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .running => "RUNNING",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .shutting_down => "SHUTTING-DOWN",
            .terminated => "TERMINATED",
            .not_found => "NOT_FOUND",
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
