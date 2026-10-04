const std = @import("std");

pub const UpdateRecommendationLifecycleStage = enum {
    pending_response,
    in_progress,
    dismissed,
    resolved,

    pub const json_field_names = .{
        .pending_response = "pending_response",
        .in_progress = "in_progress",
        .dismissed = "dismissed",
        .resolved = "resolved",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_response => "pending_response",
            .in_progress => "in_progress",
            .dismissed => "dismissed",
            .resolved => "resolved",
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
