const std = @import("std");

/// Represents the preview status.
pub const PreviewStatus = enum {
    preview_in_progress,
    preview_failed,
    preview_ready,

    pub const json_field_names = .{
        .preview_in_progress = "PREVIEW_IN_PROGRESS",
        .preview_failed = "PREVIEW_FAILED",
        .preview_ready = "PREVIEW_READY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preview_in_progress => "PREVIEW_IN_PROGRESS",
            .preview_failed => "PREVIEW_FAILED",
            .preview_ready => "PREVIEW_READY",
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
