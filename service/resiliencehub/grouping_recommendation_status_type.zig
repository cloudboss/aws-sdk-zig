const std = @import("std");

pub const GroupingRecommendationStatusType = enum {
    accepted,
    rejected,
    pending_decision,

    pub const json_field_names = .{
        .accepted = "Accepted",
        .rejected = "Rejected",
        .pending_decision = "PendingDecision",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accepted => "Accepted",
            .rejected => "Rejected",
            .pending_decision => "PendingDecision",
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
