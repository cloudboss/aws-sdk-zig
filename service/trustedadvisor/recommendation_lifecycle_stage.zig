const std = @import("std");

pub const RecommendationLifecycleStage = enum {
    in_progress,
    pending_response,
    dismissed,
    resolved,

    pub const json_field_names = .{
        .in_progress = "in_progress",
        .pending_response = "pending_response",
        .dismissed = "dismissed",
        .resolved = "resolved",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "in_progress",
            .pending_response => "pending_response",
            .dismissed => "dismissed",
            .resolved => "resolved",
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
