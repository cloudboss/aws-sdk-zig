const std = @import("std");

pub const SnapshotState = enum {
    pending,
    completed,
    @"error",
    recoverable,
    recovering,

    pub const json_field_names = .{
        .pending = "pending",
        .completed = "completed",
        .@"error" = "error",
        .recoverable = "recoverable",
        .recovering = "recovering",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .completed => "completed",
            .@"error" => "error",
            .recoverable => "recoverable",
            .recovering => "recovering",
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
