const std = @import("std");

/// Status of a recommendation
pub const RecommendationStatus = enum {
    /// Recommendation has been generated but not yet acted upon
    proposed,
    /// Recommendation has been accepted by the user
    accepted,
    /// Recommendation has been rejected by the user
    rejected,
    /// Recommendation has been closed and is no longer relevant
    closed,
    /// Recommendation has been completed by the user
    completed,
    /// Recommendation is being actively updated
    update_in_progress,

    pub const json_field_names = .{
        .proposed = "PROPOSED",
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
        .closed = "CLOSED",
        .completed = "COMPLETED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .proposed => "PROPOSED",
            .accepted => "ACCEPTED",
            .rejected => "REJECTED",
            .closed => "CLOSED",
            .completed => "COMPLETED",
            .update_in_progress => "UPDATE_IN_PROGRESS",
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
