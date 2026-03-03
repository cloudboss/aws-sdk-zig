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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
