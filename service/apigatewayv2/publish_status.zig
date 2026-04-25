const std = @import("std");

/// Represents a publish status.
pub const PublishStatus = enum {
    published,
    publish_in_progress,
    publish_failed,
    disable_in_progress,
    disable_failed,
    disabled,

    pub const json_field_names = .{
        .published = "PUBLISHED",
        .publish_in_progress = "PUBLISH_IN_PROGRESS",
        .publish_failed = "PUBLISH_FAILED",
        .disable_in_progress = "DISABLE_IN_PROGRESS",
        .disable_failed = "DISABLE_FAILED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .published => "PUBLISHED",
            .publish_in_progress => "PUBLISH_IN_PROGRESS",
            .publish_failed => "PUBLISH_FAILED",
            .disable_in_progress => "DISABLE_IN_PROGRESS",
            .disable_failed => "DISABLE_FAILED",
            .disabled => "DISABLED",
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
