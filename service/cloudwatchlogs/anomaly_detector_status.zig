const std = @import("std");

pub const AnomalyDetectorStatus = enum {
    initializing,
    training,
    analyzing,
    failed,
    deleted,
    paused,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .training = "TRAINING",
        .analyzing = "ANALYZING",
        .failed = "FAILED",
        .deleted = "DELETED",
        .paused = "PAUSED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "INITIALIZING",
            .training => "TRAINING",
            .analyzing => "ANALYZING",
            .failed => "FAILED",
            .deleted => "DELETED",
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
