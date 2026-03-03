const std = @import("std");

pub const VolumeModificationState = enum {
    modifying,
    optimizing,
    completed,
    failed,

    pub const json_field_names = .{
        .modifying = "modifying",
        .optimizing = "optimizing",
        .completed = "completed",
        .failed = "failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .modifying => "modifying",
            .optimizing => "optimizing",
            .completed => "completed",
            .failed => "failed",
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
