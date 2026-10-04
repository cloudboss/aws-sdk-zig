const std = @import("std");

pub const DeploymentStatus = enum {
    in_progress,
    impaired,
    complete,
    rollback_in_progress,
    rollback_complete,
    cancelled,
    pending,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .impaired = "IMPAIRED",
        .complete = "COMPLETE",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_complete = "ROLLBACK_COMPLETE",
        .cancelled = "CANCELLED",
        .pending = "PENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .impaired => "IMPAIRED",
            .complete => "COMPLETE",
            .rollback_in_progress => "ROLLBACK_IN_PROGRESS",
            .rollback_complete => "ROLLBACK_COMPLETE",
            .cancelled => "CANCELLED",
            .pending => "PENDING",
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
