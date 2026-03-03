const std = @import("std");

/// The warmup status of a dedicated IP.
pub const WarmupStatus = enum {
    in_progress,
    done,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .done = "DONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .done => "DONE",
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
