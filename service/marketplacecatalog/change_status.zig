const std = @import("std");

pub const ChangeStatus = enum {
    preparing,
    applying,
    succeeded,
    cancelled,
    failed,

    pub const json_field_names = .{
        .preparing = "PREPARING",
        .applying = "APPLYING",
        .succeeded = "SUCCEEDED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preparing => "PREPARING",
            .applying => "APPLYING",
            .succeeded => "SUCCEEDED",
            .cancelled => "CANCELLED",
            .failed => "FAILED",
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
