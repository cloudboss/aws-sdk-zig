const std = @import("std");

pub const StatisticalIssueStatus = enum {
    potential_issue_detected,
    no_issue_detected,

    pub const json_field_names = .{
        .potential_issue_detected = "POTENTIAL_ISSUE_DETECTED",
        .no_issue_detected = "NO_ISSUE_DETECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .potential_issue_detected => "POTENTIAL_ISSUE_DETECTED",
            .no_issue_detected => "NO_ISSUE_DETECTED",
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
