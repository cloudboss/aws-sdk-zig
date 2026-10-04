const std = @import("std");

pub const RuleEvaluationStatus = enum {
    in_progress,
    no_issues_found,
    issues_found,
    @"error",
    stopping,
    stopped,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .no_issues_found = "NoIssuesFound",
        .issues_found = "IssuesFound",
        .@"error" = "Error",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "InProgress",
            .no_issues_found => "NoIssuesFound",
            .issues_found => "IssuesFound",
            .@"error" => "Error",
            .stopping => "Stopping",
            .stopped => "Stopped",
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
