const std = @import("std");

pub const ReplicationStatus = enum {
    complete,
    pending,
    failed,
    replica,
    completed,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .pending = "PENDING",
        .failed = "FAILED",
        .replica = "REPLICA",
        .completed = "COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .complete => "COMPLETE",
            .pending => "PENDING",
            .failed => "FAILED",
            .replica => "REPLICA",
            .completed => "COMPLETED",
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
