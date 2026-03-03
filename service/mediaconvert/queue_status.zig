const std = @import("std");

/// Queues can be ACTIVE or PAUSED. If you pause a queue, jobs in that queue
/// won't begin. Jobs that are running when you pause a queue continue to run
/// until they finish or result in an error.
pub const QueueStatus = enum {
    active,
    paused,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .paused = "PAUSED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .paused => "PAUSED",
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
