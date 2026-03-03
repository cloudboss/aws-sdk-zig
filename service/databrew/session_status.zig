const std = @import("std");

pub const SessionStatus = enum {
    assigned,
    failed,
    initializing,
    provisioning,
    ready,
    recycling,
    rotating,
    terminated,
    terminating,
    updating,

    pub const json_field_names = .{
        .assigned = "ASSIGNED",
        .failed = "FAILED",
        .initializing = "INITIALIZING",
        .provisioning = "PROVISIONING",
        .ready = "READY",
        .recycling = "RECYCLING",
        .rotating = "ROTATING",
        .terminated = "TERMINATED",
        .terminating = "TERMINATING",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assigned => "ASSIGNED",
            .failed => "FAILED",
            .initializing => "INITIALIZING",
            .provisioning => "PROVISIONING",
            .ready => "READY",
            .recycling => "RECYCLING",
            .rotating => "ROTATING",
            .terminated => "TERMINATED",
            .terminating => "TERMINATING",
            .updating => "UPDATING",
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
