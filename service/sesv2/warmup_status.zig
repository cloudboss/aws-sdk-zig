const std = @import("std");

/// The warmup status of a dedicated IP.
pub const WarmupStatus = enum {
    in_progress,
    done,
    not_applicable,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .done = "DONE",
        .not_applicable = "NOT_APPLICABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .done => "DONE",
            .not_applicable => "NOT_APPLICABLE",
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
