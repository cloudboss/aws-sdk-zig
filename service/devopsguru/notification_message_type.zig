const std = @import("std");

pub const NotificationMessageType = enum {
    new_insight,
    closed_insight,
    new_association,
    severity_upgraded,
    new_recommendation,

    pub const json_field_names = .{
        .new_insight = "NEW_INSIGHT",
        .closed_insight = "CLOSED_INSIGHT",
        .new_association = "NEW_ASSOCIATION",
        .severity_upgraded = "SEVERITY_UPGRADED",
        .new_recommendation = "NEW_RECOMMENDATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new_insight => "NEW_INSIGHT",
            .closed_insight => "CLOSED_INSIGHT",
            .new_association => "NEW_ASSOCIATION",
            .severity_upgraded => "SEVERITY_UPGRADED",
            .new_recommendation => "NEW_RECOMMENDATION",
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
