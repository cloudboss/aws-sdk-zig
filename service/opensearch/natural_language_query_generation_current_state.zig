const std = @import("std");

pub const NaturalLanguageQueryGenerationCurrentState = enum {
    not_enabled,
    enable_complete,
    enable_in_progress,
    enable_failed,
    disable_complete,
    disable_in_progress,
    disable_failed,

    pub const json_field_names = .{
        .not_enabled = "NOT_ENABLED",
        .enable_complete = "ENABLE_COMPLETE",
        .enable_in_progress = "ENABLE_IN_PROGRESS",
        .enable_failed = "ENABLE_FAILED",
        .disable_complete = "DISABLE_COMPLETE",
        .disable_in_progress = "DISABLE_IN_PROGRESS",
        .disable_failed = "DISABLE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_enabled => "NOT_ENABLED",
            .enable_complete => "ENABLE_COMPLETE",
            .enable_in_progress => "ENABLE_IN_PROGRESS",
            .enable_failed => "ENABLE_FAILED",
            .disable_complete => "DISABLE_COMPLETE",
            .disable_in_progress => "DISABLE_IN_PROGRESS",
            .disable_failed => "DISABLE_FAILED",
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
